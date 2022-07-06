import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:notas/src/helpers/nota_helper.dart';
import 'package:notas/src/local_auth/local_auth.dart';
import 'package:notas/src/repositories/nota_repository_objetbox_impl.dart';
import 'package:notas/src/views/home/home_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController homeController;
  LocalAuth localAuth = LocalAuth();

  bool isAuthenticate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController = HomeController(NotaRepositoryObjectboxImpl(NotaHelper()));
    homeController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
          color: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            homeController.calledNewNotaPage(context);
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: RxBuilder(
            builder: (BuildContext context) {
              return ListView.builder(
                itemCount: homeController.rxList.length,
                itemBuilder: (context, index) {
                  return cardNota(context, index);
                },
              );
            },
          ),
        ));
  }

  Widget cardNota(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (homeController.rxList[index].status) {
          localAuth.authenticate().then((value) {
            if (value) {
              homeController.calledLookNotaPage(context, index: index);
            }
          });
        } else {
          homeController.calledLookNotaPage(context, index: index);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  if (homeController.rxList[index].status) {
                    localAuth.authenticate().then((value) {
                      if (value) {
                        FlutterShare.share(
                            title: homeController.rxList[index].title!,
                            text: homeController.rxList[index].description,
                            chooserTitle: "Compartilhar Nota");
                      }
                    });
                  }
                },
                borderRadius: BorderRadius.circular(15),
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  homeController.delete(homeController.rxList[index].id!);
                },
                borderRadius: BorderRadius.circular(15),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
            elevation: 2,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: homeController.rxList[index].status
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.rxList[index].title ?? "",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.fingerprint_rounded,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.rxList[index].title ?? "",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                homeController.rxList[index].description,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                DateFormat.yMd()
                                    .add_jm()
                                    .format(homeController.rxList[index].date),
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
