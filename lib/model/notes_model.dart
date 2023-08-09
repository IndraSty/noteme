class Notes {
  String? id;
  String? title;
  String? notesText;

  Notes({
    required this.id,
    required this.title,
    required this.notesText,
  });

  static List<Notes> noteList() {
    return [
      Notes(
        id: '01',
        title: 'Trip Investments',
        notesText:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Soluta eos veniam velit quam dolorem iusto repellat voluptatem harum sapiente, enim dignissimos, possimus ullam?!',
      ),
      Notes(
        id: '02',
        title: 'Documents Needed',
        notesText:
            'Lorem elit. Soluta eos veniam velit quam dolorem iusto repellat voluptatem harum sapiente, enim dignissimos, possimus ullam?!',
      ),
      Notes(
        id: '03',
        title: 'Company Details',
        notesText:
            'Lorem adipisicing elit. Soluta eos veniam velit quam dolorem iusto repellat voluptatem harum sapiente, enim dignissimos, possimus ullam?!',
      ),
      Notes(
        id: '04',
        title: 'First Mounth Salary',
        notesText:
            'Lorem ipsum dolor sit amet consectetur elit. Soluta eos veniam velit quam dolorem iusto repellat voluptatem harum sapiente, enim dignissimos, possimus ullam?!',
      ),
    ];
  }
}
