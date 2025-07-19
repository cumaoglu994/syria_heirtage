import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../../../../core/config/app_config.dart';

/// Audio guide page
class AudioGuidePage extends StatefulWidget {
  const AudioGuidePage({super.key});

  @override
  State<AudioGuidePage> createState() => _AudioGuidePageState();
}

class _AudioGuidePageState extends State<AudioGuidePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  String? _currentAudioUrl;
  String? _currentAudioTitle;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _audioCategories = [
    {
      'id': 'historical',
      'title': 'Historical Sites',
      'titleAr': 'المواقع التاريخية',
      'icon': Icons.history,
      'color': AppConfig.syrianGold,
      'audios': [
        {
          'id': '1',
          'title': 'Palmyra - Ancient City',
          'titleAr': 'تدمر - المدينة القديمة',
          'duration': '15:30',
          'url': 'https://example.com/audio/palmyra.mp3',
          'image':
              'https://cdn.britannica.com/51/180451-050-F25987E6/Ruins-Grand-Colonnade-Palmyra-Syria.jpg',
          'description': 'Discover the ancient city of Palmyra',
          'descriptionAr': 'اكتشف مدينة تدمر القديمة',
        },
        {
          'id': '2',
          'title': 'Umayyad Mosque',
          'titleAr': 'الجامع الأموي',
          'duration': '12:45',
          'url': 'https://example.com/audio/umayyad.mp3',
          'image':
              'https://www.islamiclandmarks.com/wp-content/uploads/2015/11/Umayyad-Mosque-exterior.jpg',
          'description': 'The story of the Great Umayyad Mosque',
          'descriptionAr': 'قصة الجامع الأموي الكبير',
        },
      ],
    },
    {
      'id': 'cultural',
      'title': 'Cultural Heritage',
      'titleAr': 'التراث الثقافي',
      'icon': Icons.museum,
      'color': AppConfig.syrianRed,
      'audios': [
        {
          'id': '3',
          'title': 'Syrian Cuisine',
          'titleAr': 'المطبخ السوري',
          'duration': '18:20',
          'url': 'https://example.com/audio/cuisine.mp3',
          'image':
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
          'description': 'Traditional Syrian dishes and recipes',
          'descriptionAr': 'الأطباق والوصفات السورية التقليدية',
        },
      ],
    },
    {
      'id': 'religious',
      'title': 'Religious Sites',
      'titleAr': 'المواقع الدينية',
      'icon': Icons.church,
      'color': AppConfig.syrianGreen,
      'audios': [
        {
          'id': '4',
          'title': 'Sacred Places',
          'titleAr': 'الأماكن المقدسة',
          'duration': '20:15',
          'url': 'https://example.com/audio/sacred.mp3',
          'image':
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
          'description': 'Religious significance of Syrian sites',
          'descriptionAr': 'الأهمية الدينية للمواقع السورية',
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });

    _audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration ?? Duration.zero;
        });
      }
    });

    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });
  }

  Future<void> _playAudio(String url, String title) async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_currentAudioUrl != url) {
        await _audioPlayer.stop();
        await _audioPlayer.setUrl(url);
        _currentAudioUrl = url;
        _currentAudioTitle = title;
      }

      await _audioPlayer.play();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error playing audio: $e')));
      }
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _currentAudioUrl = null;
      _currentAudioTitle = null;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Guide'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implement download functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_currentAudioUrl != null) _buildAudioPlayer(),
          Expanded(child: _buildAudioCategories()),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: AppConfig.primaryColor.withOpacity(0.2)),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConfig.radiusM),
                  color: AppConfig.primaryColor.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.headphones,
                  color: AppConfig.primaryColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: AppConfig.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentAudioTitle ?? 'Unknown',
                      style: AppConfig.heading3.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConfig.spacingS),
                    Text(_formatDuration(_position), style: AppConfig.body2),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_isPlaying) {
                          _pauseAudio();
                        } else {
                          _playAudio(_currentAudioUrl!, _currentAudioTitle!);
                        }
                      },
                color: AppConfig.primaryColor,
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: _isLoading ? null : _stopAudio,
                color: AppConfig.primaryColor,
              ),
            ],
          ),
          const SizedBox(height: AppConfig.spacingS),
          Slider(
            value: _position.inSeconds.toDouble(),
            max: _duration.inSeconds.toDouble(),
            onChanged: (value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
            activeColor: AppConfig.primaryColor,
            inactiveColor: AppConfig.primaryColor.withOpacity(0.3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_position), style: AppConfig.caption),
              Text(_formatDuration(_duration), style: AppConfig.caption),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAudioCategories() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      itemCount: _audioCategories.length,
      itemBuilder: (context, index) {
        final category = _audioCategories[index];
        return _buildCategoryCard(category);
      },
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: category['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConfig.radiusM),
          ),
          child: Icon(category['icon'], color: category['color'], size: 24),
        ),
        title: Text(
          category['title'],
          style: AppConfig.heading3.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${category['audios'].length} audio guides',
          style: AppConfig.body2,
        ),
        children: [
          ...category['audios'].map<Widget>((audio) => _buildAudioItem(audio)),
        ],
      ),
    );
  }

  Widget _buildAudioItem(Map<String, dynamic> audio) {
    final isCurrentAudio = _currentAudioUrl == audio['url'];

    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radiusS),
          image: DecorationImage(
            image: NetworkImage(audio['image']),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        audio['title'],
        style: AppConfig.body1.copyWith(
          fontWeight: isCurrentAudio ? FontWeight.bold : FontWeight.normal,
          color: isCurrentAudio ? AppConfig.primaryColor : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            audio['description'],
            style: AppConfig.body2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppConfig.spacingS),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppConfig.primaryColor),
              const SizedBox(width: 4),
              Text(audio['duration'], style: AppConfig.caption),
              const Spacer(),
              if (isCurrentAudio && _isPlaying)
                Icon(Icons.volume_up, size: 16, color: AppConfig.primaryColor),
            ],
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              isCurrentAudio && _isPlaying ? Icons.pause : Icons.play_arrow,
              color: AppConfig.primaryColor,
            ),
            onPressed: () {
              if (isCurrentAudio && _isPlaying) {
                _pauseAudio();
              } else {
                _playAudio(audio['url'], audio['title']);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implement download functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Download started for ${audio['title']}'),
                ),
              );
            },
          ),
        ],
      ),
      onTap: () {
        // TODO: Navigate to audio details page
      },
    );
  }
}
