
import 'package:flutter/material.dart';
import 'package:optimus/frontend/pages/home_page.dart';


Map<String, WidgetBuilder> getAplicationRoutes(){
 return <String, WidgetBuilder>{
        '/home'                  : (_) => HomePage()
      };
}
