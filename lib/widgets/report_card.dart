import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final snap;
  const ReportCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png',
                  ),
                  backgroundColor: Colors.grey,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['firstname'] + ' ' + snap['lastname'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shrinkWrap: true,
                                children: [
                                  'Borrar',
                                ]
                                    .map(
                                      (e) => InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: '${snap['likes'].length} likes',
                          ),
                        ]),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: snap['reference'],
                          ),
                        ]),
                  ),
                ),
                SizedBox(height: 10,),
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    snap['description'],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['reportUrl'],
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // color: Colors.yellow,
                    child: TextButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ))),
                        icon: Icon(Icons.thumb_up),
                        label: Text('Me gusta')),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                ),
                Expanded(
                  child: TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ))),
                      icon: Icon(Icons.chat_bubble),
                      label: Text('Comentar')),
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                ),
                Expanded(
                  child: TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ))),
                      icon: Icon(Icons.send),
                      label: Text('Compartir')),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                'Ver todos los 20 comentarios',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              '30/08/2022',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
