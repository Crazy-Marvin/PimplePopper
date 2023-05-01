extends Node

class_name Yodo1Mas

enum BannerAlign {
	BANNER_LEFT = 1, 
	BANNER_HORIZONTAL_CENTER = 1 << 1, # 2
	BANNER_RIGHT = 1 << 2, # 4
	BANNER_TOP = 1 << 3, # 8
	BANNER_VERTICAL_CENTER = 1 << 4, # 16
	BANNER_BOTTOM = 1 << 5 # 32
	}

# signals
signal banner_ad_loaded()
signal banner_ad_failed_to_loaded()
signal banner_ad_opened()
signal banner_ad_failed_to_open()
signal banner_ad_closed()

signal interstitial_ad_loaded()
signal interstitial_ad_failed_loaded()
signal interstitial_ad_opened()
signal interstitial_ad_failed_to_opened()
signal interstitial_ad_closed()

signal rewarded_ad_loaded()
signal rewarded_ad_failed_load()
signal rewarded_ad_opened()
signal rewarded_ad_failed_to_opened()
signal rewarded_ad_closed()
signal rewarded_ad_earned()

# properties
export var app_id_ios: String
export var app_id_android: String
export var IsPrivacyEnabled: bool
export var IsAppOpenAdsRequired: bool

# "private" properties
var _yodo1mas_singleton = null

# initialization

func set_gdpr(gdpr) -> void:
	print("Editor, set_gdpr: " + str(gdpr))
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.setGDPR(gdpr)

func set_ccpa(ccpa) -> void:
	print("Editor, set_ccpa: " + str(ccpa))
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.setCCPA(ccpa)
	
func set_coppa(coppa) -> void:
	print("Editor, set_coppa: " + str(coppa))
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.setCOPPA(coppa)


func _ready():
	if(Engine.has_singleton("GodotYodo1Mas")):
		_yodo1mas_singleton = Engine.get_singleton("GodotYodo1Mas")
		print("Editor, GodotYodo1Mas initialized")
	else:
		print("Editor, GodotYodo1Mas not initialized")




func init() -> bool:
	print("Initialize yodo sdk")
	if(Engine.has_singleton("GodotYodo1Mas")):

		# check if one signal is already connected
		if not _yodo1mas_singleton.is_connected("on_interstitial_ad_loaded", self, "_on_interstitial_ad_loaded"):
			connect_signals()
		
		print("OS.get_name()")

		if OS.get_name() == "iOS":
			_yodo1mas_singleton.init(app_id_ios,IsPrivacyEnabled,IsAppOpenAdsRequired)
		elif OS.get_name() == "Android":
			_yodo1mas_singleton.init(app_id_android,IsPrivacyEnabled,IsAppOpenAdsRequired)
		else:
			print("NOT Android or iOs")
			
		return true
	return false

# connect the AdMob Java signals
func connect_signals() -> void:	
	
	_yodo1mas_singleton.connect("on_banner_ad_loaded", self, "_on_banner_ad_loaded")
	_yodo1mas_singleton.connect("on_banner_ad_failed_to_load", self, "_on_banner_ad_failed_to_load")
	_yodo1mas_singleton.connect("on_banner_ad_opened", self, "_on_banner_ad_opened")
	_yodo1mas_singleton.connect("on_banner_ad_failed_to_open", self, "_on_banner_ad_failed_to_open")
	_yodo1mas_singleton.connect("on_banner_ad_closed", self, "_on_banner_ad_closed")
	
	_yodo1mas_singleton.connect("on_interstitial_ad_loaded", self, "_on_interstitial_ad_loaded")
	_yodo1mas_singleton.connect("on_interstitial_ad_failed_loaded", self, "_on_interstitial_ad_failed_loaded")

	_yodo1mas_singleton.connect("on_interstitial_ad_opened", self, "_on_interstitial_ad_opened")
	_yodo1mas_singleton.connect("on_interstitial_ad_failed_to_opened", self, "_on_interstitial_ad_failed_to_opened")
	_yodo1mas_singleton.connect("on_interstitial_ad_closed", self, "_on_interstitial_ad_closed")

	
	_yodo1mas_singleton.connect("on_rewarded_ad_loaded", self, "_on_rewarded_ad_loaded")
	_yodo1mas_singleton.connect("on_rewarded_ad_failed_load", self, "_on_rewarded_ad_failed_load")

	_yodo1mas_singleton.connect("on_rewarded_ad_opened", self, "_on_rewarded_ad_opened")
	_yodo1mas_singleton.connect("on_rewarded_ad_failed_to_opened", self, "_on_rewarded_ad_failed_to_opened")
	_yodo1mas_singleton.connect("on_rewarded_ad_closed", self, "_on_rewarded_ad_closed")
	_yodo1mas_singleton.connect("on_rewarded_ad_earned", self, "_on_rewarded_ad_earned")
	
	


# show / hide

func load_banner_ad(size: String,horizontal_alignment: String,vertical_alignment: String) -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.loadBannerAds(size,horizontal_alignment,vertical_alignment)
		

func load_appopen_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.LoadAppOpenAds()

func show_banner_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.showBannerAd()
		
		
		
func dismiss_banner_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.dismissBannerAd()

func is_interstitial_ad_loaded() -> bool:
	if(_yodo1mas_singleton == null):
		return false;
	return _yodo1mas_singleton.isInterstitialAdLoaded()
	
func initialize_interstitial_ads() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.InitializeInterstitialAds()

func load_interstitial_ads() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.LoadInterstitialAds()

func show_interstitial_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.showInterstitialAd()

func show_interstitial_ad_with_placement(placementId: String) -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.showInterstitialAdWithPlacement(placementId)

func initialize_rewarded_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.InitializeRewardedAds()

func load_rewarded_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.loadRewardedAds()

func is_rewarded_ad_loaded() -> bool:
	if(_yodo1mas_singleton == null):
		return false;
	return _yodo1mas_singleton.isRewardedAdLoaded()
	
func show_rewarded_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.showRewardedAd()

func show_rewarded_ad_with_placement(placementId: String) -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.showRewardAdWithPlacement(placementId)

func initialize_rewarded_interstitial_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.InitializeInterstitialRewardedAds()

func load_rewarded_interstitial_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.LoadInterstitialRewardedAds()

func show_rewarded_interstitial_ad() -> void:
	if(_yodo1mas_singleton != null):
		_yodo1mas_singleton.showInterstitialRewardedAd()

# callbacks

func _on_banner_ad_loaded() -> void:
	emit_signal("banner_ad_loaded")

func _on_banner_ad_failed_to_load() -> void:
	emit_signal("banner_ad_failed_to_load")

func _on_banner_ad_opened() -> void:
	emit_signal("banner_ad_opened")

func _on_banner_ad_failed_to_opened() -> void:
	emit_signal("banner_ad_failed_to_open")
	
func _on_banner_ad_closed() -> void:
	emit_signal("banner_ad_closed")



func _on_interstitial_ad_loaded() -> void:
	emit_signal("interstitial_ad_loaded")

func _on_interstitial_ad_failed_to_loaded() -> void:
	emit_signal("interstitial_ad_failed_loaded")

func _on_interstitial_ad_opened() -> void:
	emit_signal("interstitial_ad_opened")

func _on_interstitial_ad_failed_to_opened() -> void:
	emit_signal("interstitial_ad_failed_to_opened")
	
func _on_interstitial_ad_closed() -> void:
	emit_signal("interstitial_ad_closed")
	
	

func _on_rewarded_ad_loaded() -> void:
	emit_signal("rewarded_ad_loaded")

func _on_rewarded_ad_failed_to_load() -> void:
	emit_signal("rewarded_ad_failed_load")
	
func _on_rewarded_ad_opened() -> void:
	emit_signal("rewarded_ad_opened")

func _on_rewarded_ad_failed_to_opened() -> void:
	emit_signal("rewarded_ad_failed_to_opened")

func _on_rewarded_ad_closed() -> void:
	emit_signal("rewarded_ad_closed")
	
func _on_rewarded_ad_earned() -> void:
	#print("Godot app -> yodo1mas, _on_rewarded_ad_earned")
	emit_signal("rewarded_ad_earned")
	
