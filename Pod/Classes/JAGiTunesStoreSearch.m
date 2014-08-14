//
//  JAGiTunesStoreSearch.m
//  AppCaller
//
//  Created by Ryu Iwasaki on 2014/08/09.
//  Copyright (c) 2014年 JAGA. All rights reserved.
//

#import "JAGiTunesStoreSearch.h"

static NSString *kItunesSearchAPI_Lookup = @"https://itunes.apple.com/lookup";
static NSString *kItunesSearchAPI_Search = @"https://itunes.apple.com/search";

@interface JAGiTunesStoreSearch ()

@property (nonatomic) NSDictionary *iTunesSearchEntityHash;
@property (nonatomic) NSDictionary *iTunesSearchMediaTypeHash;
@property (nonatomic) NSDictionary *iTunesSearchMediaAttributeHash;
@property (nonatomic) NSDictionary *params;
@property (nonatomic) NSString *endPoint;
@property (nonatomic) NSURLSessionTask *downloadTask;
@property (nonatomic,copy) void(^resultsBlock)(NSError *error,NSArray *results);
@end

@implementation JAGiTunesStoreSearch

- (NSDictionary *)iTunesSearchEntityHash{
    
    if (_iTunesSearchEntityHash) {
        return _iTunesSearchEntityHash;
    }
    
    NSDictionary *hash = @{
        
                           @(MovieArtistiTunesSearchEntity)     :@"movieArtist",
                           @(MovieiTunesSearchEntity)           :@"movie",
                           @(PodcastAuthoriTunesSearchEntity)   :@"podcastAuthor",
                           @(PodcastiTunesSearchEntity)         :@"podcast",
                           @(MusicArtistiTunesSearchEntity)     :@"musicArtist",
                           @(MusicTrackiTunesSearchEntity)      :@"musicTrack",
                           @(AlbumiTunesSearchEntity)           :@"album",
                           @(MusicVideoiTunesSearchEntity)      :@"musicVideo",
                           @(MixiTunesSearchEntity)             :@"mix",
                           @(SongiTunesSearchEntity)            :@"song",
                           @(AudiobookAuthoriTunesSearchEntity) :@"audiobookAuthor",
                           @(AudiobookiTunesSearchEntity)       :@"audiobook",
                           @(ShortFilmArtistiTunesSearchEntity) :@"shortFilmArtist",
                           @(ShortFilmiTunesSearchEntity)       :@"shortFilm",
                           @(TvEpisodeiTunesSearchEntity)       :@"tvEpisode",
                           @(TvSeasoniTunesSearchEntity)        :@"tvSeason",
                           @(SoftwareiTunesSearchEntity)        :@"software",
                           @(iPadSoftwareiTunesSearchEntity)    :@"iPadSoftware",
                           @(MacSoftwareiTunesSearchEntity)     :@"macSoftware",
                           @(EbookiTunesSearchEntity)           :@"ebook",
                           @(AllArtistiTunesSearchEntity)       :@"allArtist",
                           @(AllTrackiTunesSearchEntity)        :@"allTrack"
        
                           };
    
    _iTunesSearchEntityHash = hash;
    
    return _iTunesSearchEntityHash;
}

- (NSDictionary *)iTunesSearchMediaTypeHash{
    
    if (_iTunesSearchMediaTypeHash) {
        return _iTunesSearchMediaTypeHash;
    }
    
    NSDictionary *hash = @{
                           
                           @(AlliTunesSearchMediaType)                  :@"",
                           @(MovieiTunesSearchMediaType)                :@"movie",
                           @(PodcastiTunesSearchMediaType)              :@"podcast",
                           @(MusiciTunesSearchMediaType)                :@"music",
                           @(MusicVideoiTunesSearchMediaType)           :@"musicVideo",
                           @(AudiobookiTunesSearchMediaType)            :@"audiobook",
                           @(ShortFilmiTunesSearchMediaType)            :@"shortFilm",
                           @(TvShowiTunesSearchMediaType)               :@"tvShow",
                           @(SoftwareiTunesSearchMediaType)             :@"software",
                           @(EbookiTunesSearchMediaType)                :@"ebook"
                           
                           };
    
    _iTunesSearchMediaTypeHash = hash;
    
    return _iTunesSearchMediaTypeHash;
    
    
}

- (NSDictionary *)iTunesSearchMediaAttributeHash{
    
    if (_iTunesSearchMediaAttributeHash) {
        return _iTunesSearchMediaAttributeHash;
    }
    
    NSDictionary *hash = @{
                           
                           @(AlliTunesSearchMediaAttribute)                 :@"",
                           @(ActorTermiTunesSearchMediaAttribute)           :@"actorTerm",
                           @(LanguageTermiTunesSearchMediaAttribute)        :@"languageTerm",
                           @(AllArtistTermiTunesSearchMediaAttribute)       :@"allArtistTerm",
                           @(TvEpisodeTermiTunesSearchMediaAttribute)       :@"tvEpisodeTerm",
                           @(ShortFilmTermiTunesSearchMediaAttribute)       :@"shortFilmTerm",
                           @(DirectorTermiTunesSearchMediaAttribute)        :@"directorTerm",
                           @(ReleaseYearTermiTunesSearchMediaAttribute)     :@"releaseYearTerm",
                           @(TitleTermiTunesSearchMediaAttribute)           :@"titleTerm",
                           @(FeatureFilmTermiTunesSearchMediaAttribute)     :@"featureFilmTerm",
                           @(RatingIndexiTunesSearchMediaAttribute)         :@"ratingIndex",
                           @(KeywordsTermiTunesSearchMediaAttribute)        :@"keywordsTerm",
                           @(DescriptionTermiTunesSearchMediaAttribute)     :@"descriptionTerm",
                           @(AuthorTermiTunesSearchMediaAttribute)          :@"authorTerm",
                           @(GenreIndexiTunesSearchMediaAttribute)          :@"genreIndex",
                           @(MixTermiTunesSearchMediaAttribute)             :@"mixTerm",
                           @(AllTrackTermiTunesSearchMediaAttribute)        :@"allTrackTerm",
                           @(ArtistTermiTunesSearchMediaAttribute)          :@"artistTerm",
                           @(ComposerTermiTunesSearchMediaAttribute)        :@"composerTerm",
                           @(TvSeasonTermiTunesSearchMediaAttribute)        :@"tvSeasonTerm",
                           @(ProducerTermiTunesSearchMediaAttribute)        :@"producerTerm",
                           @(RatingTermiTunesSearchMediaAttribute)          :@"ratingTerm",
                           @(SongTermiTunesSearchMediaAttribute)            :@"songTerm",
                           @(MovieArtistTermiTunesSearchMediaAttribute)     :@"movieArtistTerm",
                           @(ShowTermiTunesSearchMediaAttribute)            :@"showTerm",
                           @(MovieTermiTunesSearchMediaAttribute)           :@"movieTerm",
                           @(AlbumTermiTunesSearchMediaAttribute)           :@"albumTerm"
                           
                           };
    
    _iTunesSearchMediaAttributeHash = hash;
    
    return _iTunesSearchMediaAttributeHash;
}

- (void)start{
    
    [super start];
    
    [self downloadDataFromAPI:_endPoint params:_params completion:^(NSError *error, NSArray *results) {
       
        if (_resultsBlock) {
            
            _resultsBlock(error,results);
        }
        
        [self finish];
    }];
}

- (NSString *)country{

    return _params[@"country"];
}

- (int32_t)offset{
    
    return [_params[@"offset"] intValue];
}

- (int32_t)limit{
    
    return [_params[@"limit"] intValue];
}

- (void)setOffset:(int32_t)offset{
    
    NSMutableDictionary *mParams = [_params mutableCopy];
    
    mParams[@"offset"] = @(offset).stringValue;
    
    _params = mParams;
}

- (void)setLimit:(int32_t)limit{
    
    NSMutableDictionary *mParams = [_params mutableCopy];
    
    mParams[@"limit"] = @(limit).stringValue;
    
    _params = mParams;
}

- (instancetype)initWithEndPoint:(NSString *)endPoint params:(NSDictionary *)params completion:(void(^)(NSError *error,NSArray *results))completionBlock;{
 
    self = [super init];
    
    if (self) {
        
        self.endPoint = endPoint;
        self.params = params;
        self.resultsBlock = completionBlock;
    }
    
    return self;
}

- (instancetype)initWithId:(NSString *)itemId country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    self = [super init];
    
    if (self) {
        
        self.endPoint = kItunesSearchAPI_Search;
        self.params = [self _paramsWithTerms:nil bundleId:nil itemId:itemId country:country entity:entity offset:offset limit:limit mediaType:mediaType mediaAttribute:mediaAttribute];
        self.resultsBlock = completionBlock;
    }
    
    return self;
}

- (instancetype)initWithTerm:(NSString *)term country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    self = [super init];
    
    if (self) {
        
        self.endPoint = kItunesSearchAPI_Search;
        self.params = [self _paramsWithTerms:@[term] bundleId:nil itemId:nil country:country entity:entity offset:offset limit:limit mediaType:mediaType mediaAttribute:mediaAttribute];
        self.resultsBlock = completionBlock;
    }
    
    return self;
}

- (instancetype)initWithTerms:(NSArray *)terms country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute completion:(void (^)(NSError *, NSArray *))completionBlock{
    
    self = [super init];
    
    if (self) {
        
        self.endPoint = kItunesSearchAPI_Search;
        self.params = [self _paramsWithTerms:terms bundleId:nil itemId:nil country:country entity:entity offset:offset limit:limit mediaType:mediaType mediaAttribute:mediaAttribute];
        self.resultsBlock = completionBlock;
    }
    
    return self;
    
}

+ (instancetype)findWithEndPoint:(NSString *)endPoint params:(NSDictionary *)params completion:(void (^)(NSError *, NSArray *))completionBlock{
    
    JAGiTunesStoreSearch *search = [[JAGiTunesStoreSearch alloc] initWithEndPoint:endPoint params:params completion:completionBlock];
    
    return search;
}

+ (instancetype)findWithId:(NSString *)itemId country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    JAGiTunesStoreSearch *search = [[JAGiTunesStoreSearch alloc] initWithId:itemId country:country entity:entity offset:offset limit:limit mediaType:mediaType mediaAttribute:mediaAttribute completion:completionBlock];
    return search;
}

+ (instancetype)findWithTerm:(NSString *)term country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    JAGiTunesStoreSearch *search = [[JAGiTunesStoreSearch alloc] initWithTerm:term country:country entity:entity offset:offset limit:limit mediaType:mediaType mediaAttribute:mediaAttribute completion:completionBlock];
    
    return search;
}

+ (instancetype)findWithTerms:(NSArray *)terms country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    JAGiTunesStoreSearch *search = [[JAGiTunesStoreSearch alloc] initWithTerms:terms country:country entity:entity offset:offset limit:limit mediaType:mediaType mediaAttribute:mediaAttribute completion:completionBlock];
    
    return search;
    
}

// Find App
+ (instancetype)findAppWithName:(NSString *)appName developer:(NSString *)developer country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    NSMutableArray *terms = [NSMutableArray new];
    
    if (appName.length > 0) {
        [terms addObject:[NSString stringWithFormat:@"%@",appName]];
    }
    
    if (developer.length > 0) {
        [terms addObject:[NSString stringWithFormat:@"%@",developer]];
    }

   return [self findWithTerms:terms country:country entity:SoftwareiTunesSearchEntity offset:offset limit:limit mediaType:SoftwareiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:completionBlock];
}

+ (instancetype)findAppWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    return [self findWithTerms:terms country:country entity:SoftwareiTunesSearchEntity offset:offset limit:limit mediaType:SoftwareiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:completionBlock];
}

+ (instancetype)findAppWithTerms:(NSArray *)terms bundleId:(NSString *)bundleId country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    JAGiTunesStoreSearch *search = [[JAGiTunesStoreSearch alloc] init];
    
    search.endPoint = kItunesSearchAPI_Lookup;
    search.params = [search _paramsWithTerms:terms bundleId:bundleId itemId:nil country:country entity:SoftwareiTunesSearchEntity offset:offset limit:limit mediaType:SoftwareiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute];
    search.resultsBlock = completionBlock;
    return search;
}

// Find Media
+ (instancetype)findMusicWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    return [self findWithTerms:terms country:country entity:SongiTunesSearchEntity offset:offset limit:limit mediaType:MusiciTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:completionBlock];
}


+ (instancetype)findMovieWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    return [self findWithTerms:terms country:country entity:MovieiTunesSearchEntity offset:offset limit:limit mediaType:MovieiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:completionBlock];
}


+ (instancetype)findEbookWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    return [self findWithTerms:terms country:country entity:EbookiTunesSearchEntity offset:offset limit:limit mediaType:EbookiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:completionBlock];
}

+ (instancetype)findPodcastWithTerms:(NSArray *)terms country:(NSString *)country offset:(int32_t)offset limit:(int32_t)limit completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    return [self findWithTerms:terms country:country entity:PodcastiTunesSearchEntity offset:offset limit:limit mediaType:PodcastiTunesSearchMediaType mediaAttribute:AlliTunesSearchMediaAttribute completion:completionBlock];
}

- (void)cancel{
    [super cancel];
    [_downloadTask cancel];
    

}

- (void)downloadDataFromAPI:(NSString *)endpoint params:(NSDictionary *)params completion:(void(^)(NSError *error,NSArray *results))completionBlock{
    
    NSURL *URL = [self _URLForEndpoint:endpoint params:params];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    _downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
       
        if (error || self.isCancelled) {
            
            completionBlock(error,nil);
            
        } else {
            
            
            NSData *data = [NSData dataWithContentsOfURL:location];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *results = [NSMutableArray new];
            
            if (json[@"resultCount"] > 0) {
                
                for (NSDictionary *child in json[@"results"]) {
                    
                    JAGiTunesStoreSearchResultItem *r = [JAGiTunesStoreSearchResultItem createResultFromJSON:child];
                    [results addObject:r];
                }
                
            }
            
            completionBlock(error,results);
        }
    
    }];
    
    
    [_downloadTask resume];
}

- (NSURL *)_URLForEndpoint:(NSString *)endpoint params:(NSDictionary *)params{
    
    NSMutableArray *paramList = [NSMutableArray new];
    
    for (NSString *key in params.allKeys) {
        
        [paramList addObject: [NSString stringWithFormat:@"%@=%@",key,params[key]]];
        
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",endpoint,[[paramList componentsJoinedByString:@"&"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *URL = [NSURL URLWithString:urlStr];

    return URL;
}

- (NSDictionary *)_paramsWithTerms:(NSArray *)terms bundleId:(NSString *)bundleId itemId:(NSString *)itemId country:(NSString *)country entity:(iTunesSearchEntity)entity offset:(int32_t)offset limit:(int32_t)limit mediaType:(iTunesSearchMediaType)mediaType mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    if (terms) {
        
        NSString *termStr = [terms componentsJoinedByString:@"+"];
        
        if (termStr.length == 0) {
            termStr = @"";
        }
        
        params[@"term"] = termStr;
    }

    if (bundleId.length > 0) {
        
        params[@"bundleId"] = bundleId;
    }
    
    if (itemId.length > 0) {
        
        params[@"id"] = itemId;
    }
    
    NSString *countryStr = @"us";
    
    if (country.length > 0) {
        countryStr = country;
    }
    params[@"country"] = countryStr;
    
    NSString *entityStr = self.iTunesSearchEntityHash[@(entity)];
    params[@"entity"] = entityStr;
    
    NSString *offsetStr = @(offset).stringValue;
    params[@"offset"] = offsetStr;

    if (limit > 0) {
        
        params[@"limit"] = @(limit).stringValue;
    }
    
    NSString *mediaStr = self.iTunesSearchMediaTypeHash[@(mediaType)];
    params[@"media"] = mediaStr;
    
    NSString *mediaAttributeStr = self.iTunesSearchMediaAttributeHash[@(mediaAttribute)];
    params[@"attribute"] = mediaAttributeStr;
    
    return params;
}



@end


@interface JAGiTunesStoreSearchResultItem ()

@property (nonatomic,readwrite) NSDictionary *json;
@property (nonatomic,readwrite) NSDate *cacheReleaseDate;
@end

@implementation JAGiTunesStoreSearchResultItem

+ (instancetype)createResultFromJSON:(NSDictionary *)json{
    
    JAGiTunesStoreSearchResultItem *result = [[JAGiTunesStoreSearchResultItem alloc] init];
    result.json = json;
    
    return result;
    
}

- (NSString *)description{
    return [_json description];
}

- (NSString *)artistId{
    
    return [NSString stringWithFormat:@"%@",_json[@"artistId"]];
}

- (NSString *)artistLinkUrl{
    return [NSString stringWithFormat:@"%@",_json[@"artistLinkUrl"]];
}

- (NSString *)artistName{
    
    return [NSString stringWithFormat:@"%@",_json[@"artistName"]];
}

- (NSString *)artistType{
    return [NSString stringWithFormat:@"%@",_json[@"artistType"]];
}

- (NSString *)artistViewUrl{
    return [NSString stringWithFormat:@"%@",_json[@"artistViewUrl"]];
}

- (NSString *)artworkUrl100{
    return [NSString stringWithFormat:@"%@",_json[@"artworkUrl100"]];
}

- (NSString *)artworkUrl512{
    return [NSString stringWithFormat:@"%@",_json[@"artworkUrl512"]];
}

- (NSString *)artworkUrl60{
    return [NSString stringWithFormat:@"%@",_json[@"artworkUrl60"]];
}

- (NSString *)bundleId{
    return [NSString stringWithFormat:@"%@",_json[@"bundleId"]];
}

- (NSString *)collectionCensoredName{
    return [NSString stringWithFormat:@"%@",_json[@"collectionCensoredName"]];
}

- (NSString *)collectionExplicitness{
    return [NSString stringWithFormat:@"%@",_json[@"collectionExplicitness"]];
}

- (NSString *)collectionName{
    return [NSString stringWithFormat:@"%@",_json[@"collectionName"]];
}

- (NSString *)collectionViewUrl{
    return [NSString stringWithFormat:@"%@",_json[@"collectionViewUrl"]];
}

- (NSString *)contentAdvisoryRating{
    return [NSString stringWithFormat:@"%@",_json[@"contentAdvisoryRating"]];
}

- (NSString *)copyright{
    return [NSString stringWithFormat:@"%@",_json[@"copyright"]];
}

- (NSString *)country{
    return [NSString stringWithFormat:@"%@",_json[@"country"]];
}

- (NSString *)currency{
    return [NSString stringWithFormat:@"%@",_json[@"currency"]];
}

- (NSString *)descriptionStr{
    return [NSString stringWithFormat:@"%@",_json[@"descriptionStr"]];
}

- (NSString *)features{
    return [NSString stringWithFormat:@"%@",_json[@"features"]];
}

- (NSString *)formattedPrice{
    return [NSString stringWithFormat:@"%@",_json[@"formattedPrice"]];
}

- (NSString *)kind{
    return [NSString stringWithFormat:@"%@",_json[@"kind"]];
}

- (NSString *)previewUrl{
    return [NSString stringWithFormat:@"%@",_json[@""]];
}

- (NSString *)primaryGenreId{
    return [NSString stringWithFormat:@"%@",_json[@"primaryGenreId"]];
}

- (NSString *)primaryGenreName{
    return [NSString stringWithFormat:@"%@",_json[@"primaryGenreName"]];
}

- (NSString *)radioStationUrl{
    return [NSString stringWithFormat:@"%@",_json[@"radioStationUrl"]];
}

- (NSString *)releaseNotes{
    return [NSString stringWithFormat:@"%@",_json[@"releaseNotes"]];
}

- (NSString *)sellerName{
    return [NSString stringWithFormat:@"%@",_json[@"sellerName"]];
}

- (NSString *)trackCensoredName{
    return [NSString stringWithFormat:@"%@",_json[@"trackCensoredName"]];
}

- (NSString *)trackContentRating{
    return [NSString stringWithFormat:@"%@",_json[@"trackContentRating"]];
}

- (NSString *)trackExplicitness{
    return _json[@"trackExplicitness"];
}

- (NSString *)trackId{
    return _json[@"trackId"];
}

- (NSString *)trackName{
    return _json[@"trackName"];
}

- (NSString *)trackViewUrl{
    return _json[@"trackViewUrl"];
}

- (NSString *)version{
    return _json[@"version"];
}

- (NSString *)wrapperType{
    return _json[@"wrapperType"];
}

- (NSNumber *)averageUserRating{
 
    return @([[NSString stringWithFormat:@"%@",_json[@"averageUserRating"]] floatValue]);
}

- (NSNumber *)averageUserRatingForCurrentVersion{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"averageUserRatingForCurrentVersion"]] floatValue]);
}

- (NSNumber *)collectionPrice{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"collectionPrice"]] floatValue]);
}

- (NSNumber *)discCount{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"discCount"]] intValue]);
}

- (NSNumber *)discNumber{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"discNumber"]] intValue]);
}

- (NSNumber *)fileSizeBytes{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"fileSizeBytes"]] floatValue]);
}

- (NSNumber *)minimumOsVersion{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"minimumOsVersion"]] floatValue]);
}

- (NSNumber *)price{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"price"]] floatValue]);
}

- (NSNumber *)trackCount{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"trackCount"]] intValue]);
}

- (NSNumber *)trackNumber{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"trackNumber"]] intValue]);
}

- (NSNumber *)trackTimeMillis{
    
    return @([[NSString stringWithFormat:@"%@",_json[@"trackTimeMillis"]] intValue]);
}

- (NSArray *)genreIds{
    
    return [NSArray arrayWithArray:_json[@"genreIds"]];
}

- (NSArray *)genres{
    
    return [NSArray arrayWithArray:_json[@"genres"]];
}

- (NSArray *)ipadScreenshotUrls{
    
    return [NSArray arrayWithArray:_json[@"ipadScreenshotUrls"]];
}

- (NSArray *)languageCodesISO2A{
    
    return [NSArray arrayWithArray:_json[@"languageCodesISO2A"]];
}

- (NSArray *)screenshotUrls{
    
    return [NSArray arrayWithArray:_json[@"screenshotUrls"]];
}

- (BOOL)isIsGameCenterEnabled{
    
    return [[NSString stringWithFormat:@"%@",_json[@"isIsGameCenterEnabled"]] boolValue];
}

- (NSDate *)releaseDate{
    
    if (!_cacheReleaseDate) {
        //_cacheReleaseDate = dateFromString([NSString stringWithFormat:@"%@",_json[@"releaseDate"]], @"yyyy-MM-dd'T'HH:mm:ss'Z'");
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        _cacheReleaseDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",_json[@"releaseDate"]]];
    }
    
    return _cacheReleaseDate;
}

@end

NSInteger const iTUNES_STORE_SEARCH_MAX_LIMIT = 50;
@interface JAGiTunesStoreFetch ()

@property (nonatomic) JAGiTunesStoreSearch *search;
@property (nonatomic) NSDictionary *params;

@property (nonatomic) NSMutableArray *queues;

@end

@implementation JAGiTunesStoreFetch

- (instancetype)initWithTerms:(NSArray *)terms
                      country:(NSString *)country
                       entity:(iTunesSearchEntity)entity
                       offset:(int32_t)offset
                        limit:(int32_t)limit
                    mediaType:(iTunesSearchMediaType)mediaType
               mediaAttribute:(iTunesSearchMediaAttribute)mediaAttribute{
 
    
    self = [super init];
    
    if (self) {
        
        _search = [JAGiTunesStoreSearch findWithTerms:terms country:country entity:entity offset:offset limit:limit mediaType:mediaType mediaAttribute:mediaAttribute completion:nil];
    
        _queues = [NSMutableArray new];
        
    }
    
    return self;
}

- (instancetype)initWithSearch:(JAGiTunesStoreSearch *)search{
    
    self = [super init];
    
    if (self) {
        
        _search = search;
        _queues = [NSMutableArray new];
        
    }
    
    return self;
    
}

- (void)fetchedResultsForQueue:(NSOperationQueue *)queue fetchedHandler:(void(^)(NSError *error,BOOL finished,NSArray *fetchedResults))fetchedBlock{
    
    //[_queues addObject:queue];
    
    [self _fetchedResultsForQueue:queue offset:_search.offset limit:_search.limit fetchedHandler:^void(NSError *error, BOOL isFinished, NSArray *fetchedResults) {
    
        if (fetchedBlock) {
            
            fetchedBlock(error,isFinished,fetchedResults);
        }
        
    }];
}

- (void)_fetchedResultsForQueue:(NSOperationQueue *)queue offset:(int32_t)offset limit:(int32_t)limit fetchedHandler:(void(^)(NSError *error, BOOL isFinished, NSArray *fetchedResults))fetchedBlock{
    
    JAGiTunesStoreSearch *search = [JAGiTunesStoreSearch findWithEndPoint:_search.endPoint params:_search.params completion:^(NSError *error, NSArray *results) {
        
        int32_t unCalledCount  = limit;
        
        BOOL isFinished = NO;
        
        if (iTUNES_STORE_SEARCH_MAX_LIMIT > results.count) {
            
            isFinished = YES;
        }
        
        if (fetchedBlock) {
            
            fetchedBlock(error,isFinished,results);
        }
        
        if (_search.resultsBlock) {
            
            _search.resultsBlock(error,results);
        }
        
        unCalledCount -= results.count;
        
        if ( !isFinished && unCalledCount > 0) {
            
            [self _fetchedResultsForQueue:queue offset:offset + iTUNES_STORE_SEARCH_MAX_LIMIT limit:unCalledCount fetchedHandler:fetchedBlock];
        }
        
    }];
    
    search.offset = offset;
    search.limit = iTUNES_STORE_SEARCH_MAX_LIMIT;
    
    [queue addOperation:search];
    
}

@end

