import '../models/movie.dart';

const List<Movie> sampleMovies = [
  Movie(
    id: 1,
    title: 'Inception',
    posterUrl: 'https://picsum.photos/seed/inception/400/600',
    overview:
        'A thief who steals corporate secrets through dream-sharing technology '
        'is given the inverse task of planting an idea into the mind of a CEO.',
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    rating: 8.8,
    trailers: ['Inception Official Trailer', 'Inception Featurette'],
  ),
  Movie(
    id: 2,
    title: 'Interstellar',
    posterUrl: 'https://picsum.photos/seed/interstellar/400/600',
    overview:
        'A team of explorers travel through a wormhole in space in an attempt '
        'to ensure humanity\'s survival.',
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    rating: 8.6,
    trailers: ['Interstellar Official Trailer', 'Interstellar Behind the Scenes'],
  ),
  Movie(
    id: 3,
    title: 'The Dark Knight',
    posterUrl: 'https://picsum.photos/seed/darkknight/400/600',
    overview:
        'When the menace known as the Joker wreaks havoc and chaos on the people '
        'of Gotham, Batman must accept one of the greatest psychological and '
        'physical tests of his ability to fight injustice.',
    genres: ['Action', 'Crime', 'Drama'],
    rating: 9.0,
    trailers: ['The Dark Knight Trailer', 'The Dark Knight IMAX Preview'],
  ),
];
