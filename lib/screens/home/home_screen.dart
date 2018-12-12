import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nubank/common/bloc_provider.dart';
import 'package:nubank/screens/home/home_bloc.dart';
import 'package:nubank/screens/home/widgets/bottom_tile.dart';
import 'package:nubank/screens/home/widgets/card_home.dart';
import 'package:nubank/screens/home/widgets/indicator_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomeBloc>(context) ?? HomeBloc(context, this);
    _bloc.initAnimation();

    return BlocProvider<HomeBloc>(
      bloc: _bloc,
      child: Scaffold(
        body: Container(
          color: Color.fromRGBO(128, 37, 156, 1),
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                _buildProfile(),
                _buildTop(),
                _buildBottom(),
                _buildCarouselCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBottom() {
    return StreamBuilder<double>(
        initialData: _bloc.initialLeft,
        stream: _bloc.carouselLeft,
        builder: (context, y) {
          return Container(
            padding: const EdgeInsets.only(left: 20.0),
            transform: Matrix4.translationValues(
                y.data, MediaQuery.of(context).size.height * 0.81, 0),
            constraints: BoxConstraints(
              maxHeight: 96,
            ),
            child: StreamBuilder<double>(
                initialData: 1.0,
                stream: _bloc.opacityProfile,
                builder: (context, opacity) {
                  return Opacity(
                    opacity: (1.0 - opacity.data),
                    child: ListView(
                      controller: _bloc.bottomScrollController,
                      scrollDirection: Axis.horizontal,
                      children: _buildChildrenBottom(),
                    ),
                  );
                }),
          );
        });
  }

  _buildCarouselCard() {
    return StreamBuilder<double>(
        initialData: MediaQuery.of(context).size.height * 0.19,
        stream: _bloc.topProfile,
        builder: (context, y) {
          return Column(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, y.data, 1),
                child: GestureDetector(
                  onTap: _bloc.onTapCarousel,
                  onVerticalDragUpdate: _bloc.onVerticalDragUpdateCarousel,
                  onVerticalDragEnd: _bloc.onVerticalDragEndCarousel,
                  child: StreamBuilder<double>(
                    initialData: _bloc.initialLeft,
                    stream: _bloc.carouselLeft,
                    builder: (context, x) {
                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.51,
                        ),
                        transform: Matrix4.translationValues(
                          x.data,
                          0.0,
                          0,
                        ),
                        child: PageView(
                          controller: _bloc.carouselPageController,
                          scrollDirection: Axis.horizontal,
                          children: _buildChidrenCarousel(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              _buildIndicator(),
            ],
          );
        });
  }

  _buildChidrenCarousel() {
    return [
      CardHome(),
      CardHome(),
    ];
  }

  _buildChildrenBottom() {
    return [
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_profile.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Indicar\namigos",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_request_money.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Cobrar",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_transfer_in.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Depositar",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_transfer_out.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Trasnferir",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_limit_adjustment.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Ajustar\nlimite",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_pay.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Pagar",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_lock.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Bloquear",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_virtual_card.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Cartão\nvirtual",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
      BottomTile(
        onTap: () {},
        image: Image.asset(
          "assets/icons/ic_sort.png",
          width: 28,
          height: 28,
        ),
        caption: Text(
          "Organizar atalhos",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotham",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ),
    ];
  }

  _buildIndicator() {
    return StreamBuilder<double>(
        initialData: 1.0,
        stream: _bloc.opacityProfile,
        builder: (context, opacity) {
          return Opacity(
            opacity: opacity.data == 0.0 ? 1.0 : 0.0,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.02,
              ),
              transform: Matrix4.translationValues(
                  0.0, MediaQuery.of(context).size.height * 0.21, 0),
              child: Center(
                child: IndicatorWidget(
                  controller: _bloc.carouselPageController,
                  itemCount: _buildChidrenCarousel().length,
                  indicatorColor: Colors.white,
                  indicatorSize: 4.0,
                  indicatorSpacing: 12.0,
                  indicatorIncreaseSize: 1.0,
                  indicatorOpacityNotSelected: 0.5,
                  indicatorType: MaterialType.circle,
                ),
              ),
            ),
          );
        });
  }

  _buildProfile() {
    return StreamBuilder<double>(
        initialData: 0.0,
        stream: _bloc.opacityProfile,
        builder: (context, opacity) {
          return Opacity(
            opacity: opacity.data,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.82,
              ),
              transform: Matrix4.translationValues(
                0,
                MediaQuery.of(context).size.height * 0.10,
                0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Image.asset(
                        "assets/qrcode.png",
                        fit: BoxFit.cover,
                        height: 96.0,
                        width: 96.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Banco ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Gotham",
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            "260 - Nu Pagamentos S.A.",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Agência ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Gotham",
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            "0001",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 3.0,
                        bottom: 20.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Conta ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Gotham",
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            "000000-0",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                      height: 1.0,
                    ),
                    ListTile(
                      isThreeLine: false,
                      contentPadding: EdgeInsets.all(0.0),
                      dense: true,
                      leading: Image.asset(
                        "assets/icons/ic_help.png",
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        "Me ajuda",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gotham",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                      height: 1.0,
                    ),
                    ListTile(
                      isThreeLine: false,
                      contentPadding: EdgeInsets.all(0.0),
                      dense: true,
                      leading: Image.asset(
                        "assets/icons/ic_profile.png",
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        "Perfil",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gotham",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                      subtitle: Text(
                        "Nome de preferência, telefone, e-mail",
                        style: TextStyle(
                          color: Colors.white54,
                          fontFamily: "Gotham",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                      height: 1.0,
                    ),
                    ListTile(
                      isThreeLine: false,
                      contentPadding: EdgeInsets.all(0.0),
                      dense: true,
                      leading: Image.asset(
                        "assets/icons/ic_nuconta.png",
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        "Configurar NuConta",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gotham",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                      height: 1.0,
                    ),
                    ListTile(
                      isThreeLine: false,
                      contentPadding: EdgeInsets.all(0.0),
                      dense: true,
                      leading: Image.asset(
                        "assets/icons/ic_card.png",
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        "Configurar Cartão",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gotham",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                      height: 1.0,
                    ),
                    ListTile(
                      isThreeLine: false,
                      contentPadding: EdgeInsets.all(0.0),
                      dense: true,
                      leading: Image.asset(
                        "assets/icons/ic_phone.png",
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        "Configurações do app",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gotham",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                      height: 1.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 18.0),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white54, width: 1.0),
                            borderRadius: BorderRadius.circular(3.0)),
                        child: Text(
                          "SAIR DO APP",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Gotham",
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _buildTop() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.10,
      ),
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: GestureDetector(
        onTap: _bloc.onTapLogo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Image.asset(
                    "assets/nu_logo.png",
                    color: Colors.white,
                    width: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: Text(
                    "Marcelo",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Gotham",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            StreamBuilder<bool>(
                initialData: false,
                stream: _bloc.showProfilePage,
                builder: (context, snapshot) {
                  return Icon(
                    snapshot.data ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                    color: Colors.white30,
                    size: 32,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
