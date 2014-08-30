//
//  JAGiTunesStoreSearch.h
//  AppCaller
//
//  Created by Ryu Iwasaki on 2014/08/09.
//  Copyright (c) 2014年 JAGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAGMultiThreadOperation.h"

typedef NS_ENUM( int, iTunesSearchEntity){
    
    MovieArtistiTunesSearchEntity,
    MovieiTunesSearchEntity,
    PodcastAuthoriTunesSearchEntity,
    PodcastiTunesSearchEntity,
    MusicArtistiTunesSearchEntity,
    MusicTrackiTunesSearchEntity,
    AlbumiTunesSearchEntity,
    MusicVideoiTunesSearchEntity,
    MixiTunesSearchEntity,
    SongiTunesSearchEntity,
    AudiobookAuthoriTunesSearchEntity,
    AudiobookiTunesSearchEntity,
    ShortFilmArtistiTunesSearchEntity,
    ShortFilmiTunesSearchEntity,
    TvEpisodeiTunesSearchEntity,
    TvSeasoniTunesSearchEntity,
    SoftwareiTunesSearchEntity,
    iPadSoftwareiTunesSearchEntity,
    MacSoftwareiTunesSearchEntity,
    EbookiTunesSearchEntity,
    AllArtistiTunesSearchEntity,
    AllTrackiTunesSearchEntity
    
};

typedef NS_ENUM(int, iTunesSearchMediaType) {
    
    AlliTunesSearchMediaType,
    MovieiTunesSearchMediaType,
    PodcastiTunesSearchMediaType,
    MusiciTunesSearchMediaType,
    MusicVideoiTunesSearchMediaType,
    AudiobookiTunesSearchMediaType,
    ShortFilmiTunesSearchMediaType,
    TvShowiTunesSearchMediaType,
    SoftwareiTunesSearchMediaType,
    EbookiTunesSearchMediaType
    
};

typedef NS_ENUM(int, iTunesSearchMediaAttribute) {
    
    AlliTunesSearchMediaAttribute,
    ActorTermiTunesSearchMediaAttribute,
    LanguageTermiTunesSearchMediaAttribute,
    AllArtistTermiTunesSearchMediaAttribute,
    TvEpisodeTermiTunesSearchMediaAttribute,
    ShortFilmTermiTunesSearchMediaAttribute,
    DirectorTermiTunesSearchMediaAttribute,
    ReleaseYearTermiTunesSearchMediaAttribute,
    TitleTermiTunesSearchMediaAttribute,
    FeatureFilmTermiTunesSearchMediaAttribute,
    RatingIndexiTunesSearchMediaAttribute,
    KeywordsTermiTunesSearchMediaAttribute,
    DescriptionTermiTunesSearchMediaAttribute,
    AuthorTermiTunesSearchMediaAttribute,
    GenreIndexiTunesSearchMediaAttribute,
    MixTermiTunesSearchMediaAttribute,
    AllTrackTermiTunesSearchMediaAttribute,
    ArtistTermiTunesSearchMediaAttribute,
    ComposerTermiTunesSearchMediaAttribute,
    TvSeasonTermiTunesSearchMediaAttribute,
    ProducerTermiTunesSearchMediaAttribute,
    RatingTermiTunesSearchMediaAttribute,
    SongTermiTunesSearchMediaAttribute,
    MovieArtistTermiTunesSearchMediaAttribute,
    ShowTermiTunesSearchMediaAttribute,
    MovieTermiTunesSearchMediaAttribute,
    AlbumTermiTunesSearchMediaAttribute
    
};

@interface JAGiTunesStoreSearch : JAGMultiThreadOperation

@property (nonatomic,readonly) NSDictionary *params;
@property (nonatomic,readonly) NSString *endPoint;
@property (nonatomic) int32_t offset;
@property (nonatomic) int32_t limit;

- (instancetype)initWithEndPoint:(NSString *)endPoint params:(NSDictionary *)params completion:(void(^)(NSError *error,NSArray *results))completionBlock;
- (instancetype)initWithId:(NSString *)itemId country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute completion:(void(^)(NSError *error,NSArray *results))completionBlock;
- (instancetype)initWithTerm:(NSString *)term country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute  completion:(void(^)(NSError *error,NSArray *results))completionBlock;
- (instancetype)initWithTerms:(NSArray *)terms country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute  completion:(void(^)(NSError *error,NSArray *results))completionBlock;

+ (instancetype)findWithEndPoint:(NSString *)endPoint params:(NSDictionary *)params completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findWithId:(NSString *)itemId country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute  completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findWithTerm:(NSString *)term country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute  completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findWithTerms:(NSArray *)terms country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute  completion:(void(^)(NSError *error,NSArray *results))completionBlock;

// Find App
+ (instancetype)findAppWithName:(NSString *)appName developer:(NSString *)developer country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findAppWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findAppWithTerms:(NSArray *)terms bundleId:(NSString *)bundleId country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock;

// Find Media
+ (instancetype)findMusicWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findMovieWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findEbookWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock;
+ (instancetype)findPodcastWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock;

@end

@interface JAGiTunesStoreSearchResultItem : NSObject

@property (nonatomic,readonly) NSString *artistId;
@property (nonatomic,readonly) NSString *artistName;
@property (nonatomic,readonly) NSString *artistViewUrl;
@property (nonatomic,readonly) NSString *artworkUrl100;
@property (nonatomic,readonly) NSString *artworkUrl512;
@property (nonatomic,readonly) NSString *artworkUrl60;
@property (nonatomic,readonly) NSNumber *averageUserRating;
@property (nonatomic,readonly) NSNumber *averageUserRatingForCurrentVersion;
@property (nonatomic,readonly) NSString *artistType;
@property (nonatomic,readonly) NSString *amgArtistId;
@property (nonatomic,readonly) NSString *artistLinkUrl;
@property (nonatomic,readonly) NSString *bundleId;
@property (nonatomic,readonly) NSString *contentAdvisoryRating;
@property (nonatomic,readonly) NSString *currency;
@property (nonatomic,readonly) NSString *country;
@property (nonatomic,readonly) NSString *collectionName;
@property (nonatomic,readonly) NSString *collectionCensoredName;
@property (nonatomic,readonly) NSNumber *collectionPrice;
@property (nonatomic,readonly) NSString *collectionExplicitness;
@property (nonatomic,readonly) NSString *collectionViewUrl;
@property (nonatomic,readonly) NSString *copyright;
@property (nonatomic,readonly) NSString *descriptionStr;
@property (nonatomic,readonly) NSNumber *discCount;
@property (nonatomic,readonly) NSNumber *discNumber;
@property (nonatomic,readonly) NSString *features;
@property (nonatomic,readonly) NSNumber *fileSizeBytes;
@property (nonatomic,readonly) NSString *formattedPrice;
@property (nonatomic,readonly) NSArray *genreIds;
@property (nonatomic,readonly) NSArray *genres;
@property (nonatomic,readonly) NSArray *ipadScreenshotUrls;
@property (nonatomic,readonly) BOOL isGameCenterEnabled;
@property (nonatomic,readonly) NSString *kind;
@property (nonatomic,readonly) NSArray *languageCodesISO2A;
@property (nonatomic,readonly) NSNumber *minimumOsVersion;
@property (nonatomic,readonly) NSNumber *price;
@property (nonatomic,readonly) NSString *primaryGenreId;
@property (nonatomic,readonly) NSString *primaryGenreName;
@property (nonatomic,readonly) NSString *previewUrl;
@property (nonatomic,readonly) NSString *radioStationUrl;
@property (nonatomic,readonly) NSDate *releaseDate;
@property (nonatomic,readonly) NSString *releaseNotes;
@property (nonatomic,readonly) NSArray *screenshotUrls;
@property (nonatomic,readonly) NSString *sellerName;
@property (nonatomic,readonly) NSArray *supportedDevices;
@property (nonatomic,readonly) NSString *trackCensoredName;
@property (nonatomic,readonly) NSString *trackContentRating;
@property (nonatomic,readonly) NSString *trackId;
@property (nonatomic,readonly) NSString *trackName;
@property (nonatomic,readonly) NSString *trackViewUrl;
@property (nonatomic,readonly) NSNumber *trackCount;
@property (nonatomic,readonly) NSNumber *trackNumber;
@property (nonatomic,readonly) NSNumber *trackTimeMillis;
@property (nonatomic,readonly) NSString *trackExplicitness;
@property (nonatomic,readonly) NSNumber *userRatingCount;
@property (nonatomic,readonly) NSNumber *userRatingCountForCurrentVersion;
@property (nonatomic,readonly) NSString *version;
@property (nonatomic,readonly) NSString *wrapperType;

+ (instancetype)createResultFromJSON:(NSDictionary *)json;

@end

UIKIT_EXTERN NSInteger const iTUNES_STORE_SEARCH_MAX_LIMIT;

@interface JAGiTunesStoreFetch : NSObject

@property (nonatomic) NSString *country;
@property (nonatomic) iTunesSearchEntity entity;
@property (nonatomic) iTunesSearchMediaType mediaType;
@property (nonatomic) iTunesSearchMediaAttribute mediaAttribute;
@property (nonatomic) int32_t offset;
@property (nonatomic) int32_t limit;

- (instancetype)initWithSearch:(JAGiTunesStoreSearch *)search;

- (instancetype)initWithTerms:(NSArray *)terms country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute;

- (void)fetchedResultsForQueue:(NSOperationQueue *)queue fetchedHandler:(void(^)(NSError *error,BOOL finished,NSArray *fetchedResults))fetchedBlock;
@end


