import 'package:flutter/material.dart';
import 'package:fluttertestapp/blocs/counter_cubit.dart';
import 'package:fluttertestapp/containers/guardians/guardians_page.dart';
import 'package:fluttertestapp/containers/common/notfound_page.dart';
import 'package:fluttertestapp/containers/common/page_wrapper.dart';
import 'package:fluttertestapp/containers/photos/edit_photo_details.dart';
import 'package:fluttertestapp/containers/photos/photo_details.dart';
import 'package:fluttertestapp/containers/products/products_page.dart';
import 'package:fluttertestapp/models/photos_model.dart';
import 'package:fluttertestapp/models/posts_model.dart';
import 'package:fluttertestapp/containers/posts/edit_post_details.dart';
import 'package:fluttertestapp/containers/photos/photos_page.dart';
import 'package:fluttertestapp/containers/posts/post_details.dart';
import 'package:fluttertestapp/containers/posts/posts_page.dart';

class Routes {
  final _counterBloc = CounterCubit();

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProductsPage.routeName:
        return MaterialPageRoute(
            builder: (_) => PageWrapper(
                cubit: _counterBloc,
                child: const ProductsPage(title: 'Products')));
      case GuardiansPage.routeName:
        return MaterialPageRoute(
            builder: (_) => PageWrapper(
                cubit: _counterBloc,
                child: const GuardiansPage(title: 'News')));
      case PostsPage.routeName:
        return MaterialPageRoute(
            builder: (_) => PageWrapper(
                cubit: _counterBloc, child: const PostsPage(title: 'Posts')));
      case PostDetails.routeName:
        {
          var data = settings.arguments as PostsModel ??
              const PostsModel(userId: 0, id: 0, title: '', body: '');
          return MaterialPageRoute(
              builder: (_) => PageWrapper(
                  cubit: _counterBloc,
                  child: PostDetails(title: 'Post Details', data: data)));
        }
      case EditPostDetails.routeName:
        {
          var data = settings.arguments as PostsModel ??
              const PostsModel(userId: 0, id: 0, title: '', body: '');
          return MaterialPageRoute(
              builder: (_) => PageWrapper(
                  cubit: _counterBloc,
                  child:
                      EditPostDetails(title: 'Edit Post Details', data: data)));
        }
      case PhotosPage.routeName:
        return MaterialPageRoute(
            builder: (_) => PageWrapper(
                cubit: _counterBloc,
                child: const PhotosPage(title: "Gallery")));
      case PhotoDetails.routeName:
        {
          var data = settings.arguments as PhotosModel ??
              const PhotosModel(
                  albumId: '', id: '', thumbnailUrl: '', title: '', url: '');
          return MaterialPageRoute(
              builder: (_) => PageWrapper(
                  cubit: _counterBloc,
                  child: PhotoDetails(title: 'Photo Details', data: data)));
        }
      case EditPhotoDetails.routeName:
        {
          var data = settings.arguments as PhotosModel ??
              const PhotosModel(
                  albumId: '', id: '', thumbnailUrl: '', title: '', url: '');
          return MaterialPageRoute(
              builder: (_) => PageWrapper(
                  cubit: _counterBloc,
                  child: EditPhotoDetails(
                      title: 'Edit Photo Details', data: data)));
        }
      default:
    }
    return MaterialPageRoute(builder: (_) => const NotfoundPage());
  }
}

//

