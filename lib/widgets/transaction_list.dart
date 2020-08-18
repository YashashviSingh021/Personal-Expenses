import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
//import 'package:lottie/lottie.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx,constraints){
          return Column(
            children: <Widget>[
              
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(

                   'assets/images/giphy.gif',
                    fit: BoxFit.cover,
                  )),
              Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },) 
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}',style:TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width >460 ? FlatButton.icon(icon: Icon(Icons.delete),
                    textColor: Colors.red,
                    onPressed: () => deleteTx(transactions[index].id), label: Text('Delete'),)
                  : IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
