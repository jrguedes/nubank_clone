import 'package:flutter/material.dart';
import 'package:nubank/common/bloc_provider.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements Bloc {
  final BuildContext context;
  final TickerProvider tickerProvider;
  bool _init = false;

  AnimationController _initAnimationController;
  AnimationController _profileAnimationController;
  Animation<double> _animationPageView;
  Animation<double> _animationLeft;
  Animation<double> _opacityProfileAnimation;
  Animation<double> _topProfileAnimation;
  BehaviorSubject<double> _carouselLeft;
  BehaviorSubject<double> _opacityProfile;
  BehaviorSubject<double> _topProfile;
  BehaviorSubject<bool> _showProfilePage;
  RxCommand<void, void> _onTapLogo;
  RxCommand<void, void> _onTapCarousel;
  RxCommand<DragUpdateDetails, void> _onVerticalDragUpdateCarousel;
  RxCommand<DragEndDetails, void> _onVerticalDragEndCarousel;
  ScrollController _bottomScrollController;
  PageController _carouselPageController;

  double initialLeft = 500.0;

  factory HomeBloc(BuildContext context, TickerProvider tickerProvider) {
    return HomeBloc._(context, tickerProvider);
  }

  HomeBloc._(this.context, this.tickerProvider) {
    _onTapLogo = RxCommand.createSyncNoParamNoResult(_actionOnTapLogo);
    _onTapCarousel = RxCommand.createSyncNoParamNoResult(_actionOnTapCarousel);
    _onVerticalDragUpdateCarousel =
        RxCommand.createSyncNoResult(_actionOnVerticalDragUpdateCarousel);
    _onVerticalDragEndCarousel =
        RxCommand.createSyncNoResult(_actionOnVerticalDragEndCarousel);

    _carouselPageController = PageController();
    _bottomScrollController = ScrollController();
    _carouselLeft = BehaviorSubject(seedValue: initialLeft);
    _opacityProfile = BehaviorSubject(seedValue: 0.0);
    _topProfile =
        BehaviorSubject(seedValue: MediaQuery.of(context).size.height * 0.19);
    _showProfilePage = BehaviorSubject(seedValue: false);

    _buildAnimations();
  }

  ScrollController get bottomScrollController => _bottomScrollController;
  BehaviorSubject<double> get carouselLeft => _carouselLeft;
  PageController get carouselPageController => _carouselPageController;
  RxCommand<void, void> get onTapCarousel => _onTapCarousel;
  RxCommand<void, void> get onTapLogo => _onTapLogo;
  RxCommand<DragEndDetails, void> get onVerticalDragEndCarousel =>
      _onVerticalDragEndCarousel;
  RxCommand<DragUpdateDetails, void> get onVerticalDragUpdateCarousel =>
      _onVerticalDragUpdateCarousel;
  BehaviorSubject<double> get opacityProfile => _opacityProfile;
  BehaviorSubject<bool> get showProfilePage => _showProfilePage;
  BehaviorSubject<double> get topProfile => _topProfile;

  @override
  void dispose() {
    _carouselLeft.close();
    _opacityProfile.close();
    _topProfile.close();
    _showProfilePage.close();
    _onTapLogo.dispose();
    _onTapCarousel.dispose();
    _onVerticalDragUpdateCarousel.dispose();
    _onVerticalDragEndCarousel.dispose();
    _bottomScrollController.dispose();
    _carouselPageController.dispose();

    _initAnimationController.dispose();
    _profileAnimationController.dispose();
  }

  void initAnimation() {
    if (!_init) {
      _initAnimationController.forward();
    }
  }

  void _actionOnTapCarousel() {
    if (showProfilePage.value) {
      _profileAnimationController.reverse();
    }
  }

  void _actionOnTapLogo() {
    if (showProfilePage.value) {
      _profileAnimationController.reverse();
    } else {
      _profileAnimationController.forward();
    }
  }

  void _actionOnVerticalDragEndCarousel(DragEndDetails param) {
    if ((!showProfilePage.value) && (_profileAnimationController.value > 0.2)) {
      _profileAnimationController.forward();
    } else {
      _profileAnimationController.reverse();
    }
  }

  void _actionOnVerticalDragUpdateCarousel(DragUpdateDetails param) {
    var delta = 0.0;

    if (showProfilePage.value) {
      delta = param.primaryDelta / 200.0;
    } else {
      delta = param.primaryDelta / 700.0;
    }

    _profileAnimationController.value += delta;
  }

  void _buildAnimations() {
    _initAnimationController = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: 1500));
    _profileAnimationController = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: 500))
      ..addStatusListener((x) {
        switch (_profileAnimationController.status) {
          case AnimationStatus.completed:
            showProfilePage.sink.add(true);
            break;
          case AnimationStatus.dismissed:
            break;
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            showProfilePage.sink.add(false);
            break;
        }
      });

    _opacityProfileAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_profileAnimationController)
          ..addListener(() {
            opacityProfile.sink.add(_opacityProfileAnimation.value);
          });

    _topProfileAnimation = Tween(
            begin: MediaQuery.of(context).size.height * 0.20,
            end: MediaQuery.of(context).size.height - 60)
        .animate(CurvedAnimation(
            curve: Curves.easeInOut, parent: _profileAnimationController))
          ..addListener(() {
            topProfile.sink.add(_topProfileAnimation.value);
          });

    _animationLeft = Tween(begin: initialLeft, end: 0.0).animate(
      CurvedAnimation(
        parent: _initAnimationController,
        curve: Interval(
          0.0,
          0.4,
          curve: Curves.easeIn,
        ),
      ),
    )..addListener(() {
        carouselLeft.add(_animationLeft.value);
      });

    _animationPageView = Tween(begin: 50.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _initAnimationController,
        curve: Interval(
          0.41,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    )..addListener(() {
        _carouselPageController.jumpTo(_animationPageView.value);
        _bottomScrollController.jumpTo(_animationPageView.value);
      });
  }
}
