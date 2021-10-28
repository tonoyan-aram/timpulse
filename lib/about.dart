import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/main_drower.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.orange));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Մեր մասին'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 15, 12, 40),
          child: Column(
            children: [
              Text(
                  "«Գործընկերություն և ուսուցում» ՀԿ-ն 2020թ. նոյեմբերի 1-ից ՀՀ-ում իրականացնում է «Նորարարություն փոփոխության"
                  " համար-Հայաստան/I4C Armenia» ծրագիրը, որը ֆինանսավորվում է TIDES կենտրոնի և ԱՄՆ ՄԶԳ-ի կողմից: Ծրագրի շրջանակում ««Կոմպասս» "
                  "գիտահետազոտական, կրթական և խորհրդատվական կենտրոն» հասարակական կազմակերպությունը  իրականացնում է «Նորարար բջջային հավելված՝"
                  " հանուն քաղաքացիների ներգրավվածության ու ՏԻՄ կառավարման բարելավման Գյումրիում» ծրագիրը։ Ծրագիրը միտված է առավել ամուր եւ կայուն հիմքի վրա կառուցել համայնքի բնակիչ- "
                  "քաղաքացիական հասարակություն-տեղական ինքնակառավարման մարմին հարաբերությունները ստեղծվող գործիքի օգնությամբ, որը հնարավորություն կտա "
                  "համայնքի բնակչին մասնակցություն ունենալ համայնքային խնդիրների լուծմանը, համայնքապետարանի թափանցիկ գործունեության ապահովմանը,"
                  " համայնքային ռեսուրսների օպտիմալ օգտագործմանը, իսկ համայնքապետարանին ու ավագանուն՝ առավել փաստարկված ու մասնակցային որոշումների կայացմանը։"
                  " Ծրագրի նպատակն է  նպաստել Գյումրի համայնքում քաղաքացիների ներգրավվածության բարձրացմանը համայնքի իշխանությունների կողմից կայացվող որոշումներում՝"
                  "ներդնելով հաշվետվողականության ու մասնակցայնության ապահովման նորարար համակարգ։""",style: TextStyle(fontSize: 17),),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/annaniks.png",
                    height: 25,
                    width: 25,
                    //fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10,),
                  Text("Աննանիկս ՍՊԸ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
    );
  }
}
