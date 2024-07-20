import 'dart:math'; // Importing math for Random
import 'package:counter_blocapp/models/pizza_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_blocapp/bloc/pizza_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PizzaBloc()..add(LoadPizzaCounter()))
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random(); // Initialize Random instance

    return Scaffold(
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              return const CircularProgressIndicator(color: Colors.orange);
            }
            if (state is PizzaLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${state.pizzas.length}', style: TextStyle(fontSize: 50)),
                  SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height-100,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        for (int index = 0; index < state.pizzas.length; index++)
                          Positioned(
                            left: random.nextInt(250).toDouble(),
                            top: random.nextInt(250).toDouble(),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: state.pizzas[index].image,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }
            else{
              return const Text('Something gone wrong'); 
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        FloatingActionButton(
          onPressed: (){
            context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[0]));
          },
          child: Icon(Icons.local_pizza_outlined),
          backgroundColor: Colors.orange[800],
        ),
        FloatingActionButton(
          onPressed: (){
            context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[0]));
          },
          child: Icon(Icons.remove),
          backgroundColor: Colors.orange[800],

        ),
        FloatingActionButton(
          onPressed: (){
            context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[1]));
          },
          child: Icon(Icons.local_pizza),
          backgroundColor: Colors.orange[800],
        ),
        FloatingActionButton(
          onPressed: (){
            context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[1]));
          },
          child: Icon(Icons.remove),
          backgroundColor: Colors.orange[800],
        ),
      ],),
    );
  }
}
