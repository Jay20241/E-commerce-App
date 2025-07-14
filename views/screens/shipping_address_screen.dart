import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/controllers/auth_controller.dart';
import 'package:multistoreapp/provider/user_provider.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  //_ShippingAddressScreenState createState() => _ShippingAddressScreenState();
  ConsumerState<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;

  

  //show loading dialog
  _showLoadingDialog(){
    showDialog(context: context, builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Updating.....')
            ],
          ),
        ),
      );
    });
  }


  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    _stateController = TextEditingController(text: user?.state ?? "");
    _cityController = TextEditingController(text: user?.city ?? "");
    _localityController = TextEditingController(text: user?.locality ?? "");
  }



  @override
  Widget build(BuildContext context) {

    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Delivery'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Where will your order\n be shipped',
                textAlign: TextAlign.center
                ),
            
                TextFormField(
                  controller: _stateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fill';
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'State'
                  ),
                ),
            
                SizedBox(height: 15),
            
                TextFormField(
                  controller: _cityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fill';
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'City'
                  ),
                ),
            
                SizedBox(height: 15),
            
                TextFormField(
                  controller: _localityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fill';
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Locality'
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async{
            if (_formKey.currentState!.validate()) {

              _showLoadingDialog();

              await _authController.updateUserLocation(
                context: context, 
                id: user!.id, 
                state: _stateController.text, 
                city: _cityController.text, 
                locality: _localityController.text,
                ref: ref
                ).whenComplete((){
                  updateUser.recreateUserState(state: _stateController.text, city: _cityController.text, locality: _localityController.text);
                  Navigator.pop(context); //This will close the dialog
                  Navigator.pop(context); //This will close the shipping screen
                });
            }else{
              print('Not Valid');
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}