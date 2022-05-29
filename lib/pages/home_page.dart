import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite/db/db_admin.dart';
import 'package:flutter_codigo5_sqflite/ui/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/book_model.dart';
import '../ui/widgets/input_textfield_widget.dart';
import '../ui/widgets/item_book_widget.dart';
import '../ui/widgets/item_slider_widget.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> books = [];
  int idBook=0;
  TextEditingController _tituloController = new TextEditingController();
  TextEditingController _authorController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _imageController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //DBAdmin.db.DeleteRaw();
    getData();

    //DBAdmin.db.initDB();
    //DBAdmin.db.getBooksRaw();
    //DBAdmin.db.getBooks();

    //DBAdmin.db.insertBook();
  }

  getData() {
    DBAdmin.db.getBooks().then((value) {
      books = value;
      setState(() {});
    });
  }

  _showForm(bool add) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87.withOpacity(0.6),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  add ? 'Agregar libro' : 'Actualizar libro',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  width: 80,
                  height: 3,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(18)),
                ),
                const SizedBox(
                  height: 16,
                ),
                InputTextFieldWidget(
                  text: 'titulo',
                  icono: 'bx-book.svg',
                  controller: _tituloController,
                ),
                InputTextFieldWidget(
                  text: 'author',
                  icono: 'bx-user.svg',
                  controller: _authorController,
                ),
                InputTextFieldWidget(
                  text: 'description',
                  icono: 'bx-paragraph.svg',
                  maxline: 2,
                  controller: _descriptionController,
                ),
                InputTextFieldWidget(
                  text: 'imagen',
                  icono: 'bx-image-add.svg',
                  controller: _imageController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: GoogleFonts.poppins(color: Colors.white60),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        BookModel book = BookModel(

                          title: _tituloController.text,
                          author: _authorController.text,
                          description: _descriptionController.text,
                          image: _imageController.text,
                        );

                       if(add) {
                         DBAdmin.db.insertBook(book).then((value) {
                           if (value > 0) {
                             getData();
                             Navigator.pop(context);
                             _tituloController.clear();
                             _authorController.clear();
                             _descriptionController.clear();
                             _imageController.clear();
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 backgroundColor: Colors.greenAccent,
                                 duration: const Duration(seconds: 3),
                                 content: Row(
                                   children: [
                                     Icon(
                                       Icons.check,
                                       color: Colors.white,
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     Expanded(
                                       child: Text(
                                         'El libro fue agregado correctamente',

                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                           }
                         });
                       }else {
                         book.id=idBook;
                         DBAdmin.db.updateBook(book).then((value) {
                           if (value > 0) {
                             getData();
                             Navigator.pop(context);
                             _tituloController.clear();
                             _authorController.clear();
                             _descriptionController.clear();
                             _imageController.clear();
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 backgroundColor: Colors.greenAccent,
                                 duration: const Duration(seconds: 3),
                                 content: Row(
                                   children: [
                                     Icon(
                                       Icons.check,
                                       color: Colors.white,
                                     ),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     Expanded(
                                       child: Text(
                                         'El libro fue modificado correctamente',
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                           }
                         });
                       }
                        // setState(() {
                        //
                        // });
                      },
                      child: Text(
                        'Aceptar',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _deleteForm() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87.withOpacity(0.6),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                   'Eliminar libro',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  width: 80,
                  height: 3,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(18)),
                ),
                const SizedBox(
                  height: 16,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: GoogleFonts.poppins(color: Colors.white60),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                      int id=idBook;



                          DBAdmin.db.deleteBook(id).then((value) {
                            if (value > 0) {
                              getData();
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.greenAccent,
                                  duration: const Duration(seconds: 3),
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'El libro fue eliminado',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          });

                        // setState(() {
                        //
                        // });
                      },
                      child: Text(
                        'Aceptar',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () {
          _tituloController.clear();
          _authorController.clear();
          _descriptionController.clear();
          _imageController.clear();
          _showForm(true);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Buenos dias",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Fiorella de Fatima",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Buscar",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: kPrimaryColor.withOpacity(0.45),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Ver mas',
                      style: GoogleFonts.poppins(
                        color: Colors.white38,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                // SingleChildScrollView(
                //   physics: const BouncingScrollPhysics(),
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       ItemSliderWidget(),
                //       ItemSliderWidget(),
                //     ],
                //   ),
                // ),

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: books
                        .map<Widget>((e) => GestureDetector(
                              onLongPress: () {
                                idBook=e.id!;
                                _tituloController.text = e.title;
                                _authorController.text = e.author;
                                _descriptionController.text = e.description;
                                _imageController.text = e.image;
                                _showForm(false);
                              },
                      onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(book: e,)));
                      },


                              child: ItemSliderWidget(
                                // title: e.title,
                                // author: e.author,
                                // image: e.image,
                                model: e,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                Column(
                  children: books
                      .map<Widget>((e) => GestureDetector(
                    onLongPress: () {
                      idBook=e.id!;
                      _tituloController.text = e.title;
                      _authorController.text = e.author;
                      _descriptionController.text = e.description;
                      _imageController.text = e.image;
                      _showForm(false);
                    },
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(book: e,)));
                    },

                        child: itemBookWidget(
                              // title: e.title,
                              // author: e.author,
                              // description: e.description,
                              // image: e.image,
                              model: e,
                          onTap: (){
                            _deleteForm();

                          },
                            ),
                      ))
                      .toList(),
                ),
                const SizedBox(
                  height: 50,
                ),

                // FutureBuilder(
                //   future: DBAdmin.db.getBooks(),
                //   builder: (BuildContext context, AsyncSnapshot snap) {
                //     if (snap.hasData) {
                //       List list = snap.data;
                //       return SingleChildScrollView(
                //         physics: const BouncingScrollPhysics(),
                //         scrollDirection: Axis.horizontal,
                //         child: Row(
                //           children: list
                //               .map((e) => ItemSliderWidget(
                //             title: e['title'],
                //             author: e['author'],
                //             image:  e['image'],
                //           ))
                //               .toList(),
                //         ),
                //       );
                //
                //
                //
                //     }
                //     return const Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   },
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                //itemBookWidget(books1: books),
                // FutureBuilder(
                //   future: DBAdmin.db.getBooks(),
                //   builder: (BuildContext context, AsyncSnapshot snap) {
                //     if (snap.hasData) {
                //       List list = snap.data;
                //       return Column(
                //         children: list
                //             .map((e) => itemBookWidget(
                //                   title: e['title'],
                //                   author: e['author'],
                //                   description: e['description'],
                //                   image: e['image'],
                //                 ))
                //             .toList(),
                //       );
                //
                //       // return ListView.builder(
                //       //     itemCount: books.length,
                //       //     itemBuilder: (BuildContext context, int index){
                //       //       return itemBookWidget();
                //       //     },
                //       //   );
                //     }
                //     return const Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text("Books"),
      // ),
      // body: FutureBuilder(
      //   future:  DBAdmin.db.getBooksRaw(),
      //   builder: (BuildContext context, AsyncSnapshot snap){
      //     if(snap.hasData){
      //       List bookList=snap.data;
      //       return ListView.builder(
      //         itemCount: bookList.length,
      //         itemBuilder: (BuildContext context, int index){
      //           return ListTile(
      //             title: Text(bookList[index]['title']),
      //           );
      //         },
      //
      //       );
      //     }
      //     return Text('ss');
      //   },
      // )
      // body: ListView.builder(
      //   itemCount: books.length,
      //   itemBuilder: (BuildContext context, int index){
      //     return ListTile(
      //       title: Text(books[index]['title']),
      //     );
      //   },
      // ),
    );
  }
}
