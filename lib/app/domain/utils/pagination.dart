class Pagination {
  int page = 1;
  int limit = 1;
  // int get page {
  //   return _page;
  // }

  // set page(int page) {
  //   // _page = page;
  //   _page = _page >= 1 ? _page - 1 : 0;
  // }

  // int get limit {
  //   return _limit;
  // }

  // set limit(int limit) {
  //   // _limit = limit;
  //   _limit = _limit >= 1 ? _limit : 1;
  // }

  @override
  String toString() => 'Pagination(skip: $page, limit: $limit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pagination && other.page == page && other.limit == limit;
  }

  @override
  int get hashCode => page.hashCode ^ limit.hashCode;
}
