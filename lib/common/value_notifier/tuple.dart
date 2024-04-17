abstract class BaseTuple<T> {
  List<R> toTypeList<R>({
    bool growable = false,
  });
}

class Tuple2<T1, T2> extends BaseTuple {
  T1 item1;
  T2 item2;

  Tuple2(
    this.item1,
    this.item2,
  );

  @override
  List<R> toTypeList<R>({bool growable = false}) {
    return List<R>.from(
      [item1, item2],
      growable: growable,
    );
  }

  factory Tuple2.fromList(List list) {
    return Tuple2(list[0],list[1]);
  }
}

class Tuple3<T1, T2, T3> extends BaseTuple {
  T1 item1;
  T2 item2;
  T3 item3;

  Tuple3(
    this.item1,
    this.item2,
    this.item3,
  );

  @override
  List<R> toTypeList<R>({bool growable = false}) {
    return List<R>.from(
      [item1, item2, item3],
      growable: growable,
    );
  }

  factory Tuple3.fromList(List list) {
    return Tuple3(list[0],list[1],list[2]);
  }
}

class Tuple4<T1, T2, T3, T4> extends BaseTuple {
  T1 item1;
  T2 item2;
  T3 item3;
  T4 item4;

  Tuple4(
    this.item1,
    this.item2,
    this.item3,
    this.item4,
  );

  @override
  List<R> toTypeList<R>({bool growable = false}) {
    return List<R>.from(
      [item1, item2, item3, item4],
      growable: growable,
    );
  }

  factory Tuple4.fromList(List list) {
    return Tuple4(list[0],list[1],list[2],list[3]);
  }
}

class Tuple5<T1, T2, T3, T4, T5> extends BaseTuple {
  T1 item1;
  T2 item2;
  T3 item3;
  T4 item4;
  T5 item5;

  Tuple5(
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
  );

  @override
  List<R> toTypeList<R>({bool growable = false}) {
    return List<R>.from(
      [item1, item2, item3, item4, item5],
      growable: growable,
    );
  }

  factory Tuple5.fromList(List list) {
    return Tuple5(list[0],list[1],list[2],list[3],list[4]);
  }
}

class Tuple6<T1, T2, T3, T4, T5, T6> extends BaseTuple {
  T1 item1;
  T2 item2;
  T3 item3;
  T4 item4;
  T5 item5;
  T6 item6;

  Tuple6(
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
    this.item6,
  );

  @override
  List<R> toTypeList<R>({bool growable = false}) {
    return List<R>.from(
      [item1, item2, item3, item4, item5, item6],
      growable: growable,
    );
  }

  factory Tuple6.fromList(List list) {
    return Tuple6(list[0],list[1],list[2],list[3],list[4],list[5]);
  }
}

class Tuple7<T1, T2, T3, T4, T5, T6, T7> extends BaseTuple {
  T1 item1;
  T2 item2;
  T3 item3;
  T4 item4;
  T5 item5;
  T6 item6;
  T7 item7;

  Tuple7(
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
    this.item6,
    this.item7,
  );

  @override
  List<R> toTypeList<R>({bool growable = false}) {
    return List<R>.from(
      [
        item1,
        item2,
        item3,
        item4,
        item5,
        item6,
        item7,
      ],
      growable: growable,
    );
  }

  factory Tuple7.fromList(List list) {
    return Tuple7(list[0],list[1],list[2],list[3],list[4],list[5],list[6]);
  }
}
