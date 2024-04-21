
  void alertDialogdelete(BuildContext context, Todo item) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Todo löschen'),
      content: const Text('Möchten Sie diese Todo wirklich löschen?'),
      actions: [
        
        TextButton(
          child: const Text('Löschen'),
          onPressed: () {
            final todoProvider = Provider.of<TodoProvider>(context, listen: false);
            todoProvider.removeTodo(item);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Todo gelöscht'),
                action: SnackBarAction(
                  label: 'Rückgängig',
                  onPressed: () {
                    todoProvider.addTodo(item);
                  },
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}