class PopularMovies {
  late int page;
  late int totalResults;
  late int totalPages;
  late List<Results> results;

  PopularMovies(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  PopularMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  late double popularity;
  late int voteCount;
  late bool video;
  late String posterPath;
  late int id;
  late bool adult;
  late String backdropPath;
  late String originalTitle;
  late String overview;
  late String releaseDate;
  late String title;
  late double voteAverage;
  late List<int> genreIds;
  late String originalLanguage;

  Results(
      {required this.popularity,
      required this.voteCount,
      required this.adult,
      required this.backdropPath,
      required this.originalTitle,
      required this.overview,
      required this.genreIds,
      required this.originalLanguage,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.posterPath,
      required this.video,
      required this.id});

  Results.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    adult = json['adult'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
