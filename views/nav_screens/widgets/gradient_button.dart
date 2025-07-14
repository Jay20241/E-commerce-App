import 'package:flutter/material.dart';

class GradientButtonDemo extends StatefulWidget {

  final String btnText;
  const GradientButtonDemo({super.key, required this.btnText});

  @override
  _GradientButtonDemoState createState() => _GradientButtonDemoState();
}

class _GradientButtonDemoState extends State<GradientButtonDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

   
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        
        //Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
      }
    });
  }

  void _onTap() {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LinearGradient _buildGradient(double value) {
    return LinearGradient(
      colors: [Colors.grey, Colors.green],
      stops: [value, value],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return GestureDetector(
              onTap: _onTap,
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  gradient: _buildGradient(_animation.value),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.btnText,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
