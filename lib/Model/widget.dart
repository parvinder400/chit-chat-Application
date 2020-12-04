import 'package:flutter/material.dart';

class BgIMG extends StatelessWidget {
  final String imglocation;

  const BgIMG({Key key, this.imglocation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class EntryBoxConst extends StatelessWidget {
  final String hinttext;
  final TextEditingController textController;
  final bool obscureText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String email;
  final keyboardType;
  final ValueChanged<String> validator;

  const EntryBoxConst({
    Key key,
    this.hinttext,
    this.textController,
    this.obscureText = false,
    this.icon,
    this.onChanged,
    this.email,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: textController ?? TextEditingController(),
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.white,
            ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(icon, color: Colors.white),

          hintText: hinttext,
          hintStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          // contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

class BtnConst extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bdcolor;
  final IconData btnicon;

  const BtnConst(
      {Key key,
      this.text,
      this.onPressed,
      this.btnicon,
      this.bdcolor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 60, right: 60, bottom: 10, top: 20),
        child: OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: bdcolor,
            width: 3.0,
          ),
          color: Colors.white,
          child: SizedBox(
            height: 60.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (btnicon != null)
                  Icon(
                    btnicon,
                    size: 20.0,
                    color: Colors.white,
                  ),
                Expanded(
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class BottomNavText extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;

  const BottomNavText({Key key, this.text1, this.text2, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
                color: Colors.blue[100],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget containerWithBackground({@required String assetUrl, Widget child}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(assetUrl),
        fit: BoxFit.cover,
      ),
    ),
    child: child,
  );
}
