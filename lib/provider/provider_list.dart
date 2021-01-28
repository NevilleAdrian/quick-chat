import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'auth_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<Auth>(create: (_) => Auth()),
];
