// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pet_style/blocs/network/network_bloc.dart';

// class NoInternetScreen extends StatelessWidget {
//   final VoidCallback onRetry;

//   const NoInternetScreen({super.key, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<NetworkBloc, NetworkState>(
//       listener: (context, state) {
//         if (state is NetworkConnected) {
//           context.go('/home');
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Ошибка соединения')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('Нет интернет соединения.'),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   BlocProvider.of<NetworkBloc>(context)
//                       .add(CheckNetworkConnection());
//                 },
//                 child: const Text('Повторить попытку'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
