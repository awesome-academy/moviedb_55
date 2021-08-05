//
//  DatabaseManager.swift
//  MovieDBApp
//
//  Created by Phong Le on 04/08/2021.
//

import Foundation
import RxSwift
import Then
import CoreData

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let presistentContainer: NSPersistentContainer
    
    private init() {
        presistentContainer = NSPersistentContainer(name: "MoviesDatabase")
        presistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                print("Load MoviesDatabase failed: \(error.localizedDescription)")
            }
        }
    }
    
    func checkMovieExist(id: Int) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        let request = MovieEntity.fetchRequest() as NSFetchRequest<MovieEntity>
        
        return Observable.create { observer in
            do {
                let movies = try context.fetch(request)
                if movies.contains(where: { $0.id == id}) {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.checkMovieExistFailed)
            }
            return Disposables.create()
        }
    }
    
    func addFavoriteMovie(movie: Movie) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        
        return Observable.create { observer in
            do {
                MovieEntity(context: context).do {
                    $0.id = Int32(movie.id)
                    $0.poster = movie.poster
                    $0.dayRelease = movie.dayRelease
                    $0.overview = movie.description
                    $0.title = movie.title
                    $0.vote = Int32(movie.vote)
                }
                
                try context.save()
                print("added movie!")
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                print("add movies failed")
                observer.onError(DatabaseError.addMovieFailed)
            }
            return Disposables.create()
        }
    }
    
    func deleteFavoriteMovie(id: Int) -> Observable<Bool> {
        let context = presistentContainer.viewContext
        let request = MovieEntity.fetchRequest() as NSFetchRequest<MovieEntity>
        
        return Observable.create { observer in
            do {
                if let movies = try? context.fetch(request) {
                    for movie in movies where movie.id == id {
                        context.delete(movie)
                        try context.save()
                        print("delete movie!")
                        observer.onNext(false)
                        observer.onCompleted()
                    }
                }
            } catch {
                print("delete movie failed")
                observer.onError(DatabaseError.deleteMovieFailed)
            }
            return Disposables.create()
        }
    }
    
    func getAllMovieFavorite() -> Observable<[Movie]> {
        let context = presistentContainer.viewContext
        return Observable.create { observer in
            do {
                let request = MovieEntity.fetchRequest() as NSFetchRequest<MovieEntity>
                let moviesEntity = try context.fetch(request)
                
                let movies = moviesEntity.map { (movie) -> Movie in
                    return Movie(
                        id: Int(movie.id),
                        title: movie.title ?? "",
                        description: movie.overview ?? "",
                        poster: movie.poster ?? "",
                        vote: Int(movie.vote),
                        dayRelease: movie.dayRelease ?? ""
                    )
                }
                
                observer.onNext(movies)
                observer.onCompleted()
            } catch {
                print("get all movie failed")
                observer.onError(DatabaseError.getAllMovieFailed)
            }
            return Disposables.create()
        }
    }
}
