import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/boss_session.dart';
import 'package:death_counter/models/game_model.dart';

// Provides all database operations
class FirestoreService {

  final _firestoreInstance = FirebaseFirestore.instance;

  FirebaseFirestore get firestoreInstance => _firestoreInstance;


  // Collections
  CollectionReference<Map<String, dynamic>> gamesCollection(String uid) {
    return _firestoreInstance.collection('users').doc(uid).collection('games');
  }

  CollectionReference<Map<String, dynamic>> bossesCollection(String uid, String gameId) {
    return _firestoreInstance.collection('users').doc(uid).collection('games').doc(gameId).collection('bosses');
  }

  // Streams
  Stream<List<GameModel>> gamesStream(String uid) =>
    gamesCollection(uid).snapshots()
    .map((snapshot) => snapshot.docs.map(GameModel.fromFirestore).toList());

  Stream<List<BossModel>> bossesStream(String uid, String gameId) =>
    bossesCollection(uid, gameId).snapshots()
    .map((snapshot) => snapshot.docs.map(BossModel.fromFirestore).toList());

  // Writes games
  Future<void> addGame(String uid, GameModel game) =>
    gamesCollection(uid).add(game.toFirestore());

  Future<void> deleteGame(String uid, String gameId) async {
    final batch = _firestoreInstance.batch();

    final bossesSnapshot = await bossesCollection(uid, gameId).get();
    for(final bossDocument in bossesSnapshot.docs) {
      batch.delete(bossDocument.reference);
    }
    batch.delete(gamesCollection(uid).doc(gameId));

    await batch.commit();
  }

  Future<void> updateGame(String uid, String gameId, String? gameIconPath, String? gameName, int? gameDeaths) async {

    final oldGameSnapshot =  await gamesCollection(uid).doc(gameId).get();
    GameModel oldGame = GameModel.fromFirestore(oldGameSnapshot);

    GameModel newGame = GameModel(
      gameIconPath: (gameIconPath?.isNotEmpty ?? false)? gameIconPath! : oldGame.gameIconPath,
      gameName: (gameName?.isNotEmpty ?? false)? gameName! : oldGame.gameName,
      gameDeaths: (gameDeaths != null)? gameDeaths : oldGame.gameDeaths
    );

    return gamesCollection(uid).doc(gameId).update(newGame.toFirestore());
  }


  // Writes bosses
  Future<void> addBoss(String uid, String gameId, BossModel boss) async {
    final batch = _firestoreInstance.batch();
    final newBossDoc = bossesCollection(uid, gameId).doc();

    batch.set(newBossDoc, boss.toFirestore());

    final int deaths = boss.bossDeaths?? 0;
    if(deaths != 0) {
      batch.set(
        gamesCollection(uid).doc(gameId),
        {'gameDeaths' : FieldValue.increment(deaths)},
        SetOptions(merge: true),
      );
    }

    await batch.commit();
  }

  Future<void> deleteBoss(String uid, String gameId, String bossId, int bossDeaths) async {
    final batch = _firestoreInstance.batch();

    batch.delete(bossesCollection(uid, gameId).doc(bossId));

    if(bossDeaths != 0) {
      batch.set(
        gamesCollection(uid).doc(gameId),
        {'gameDeaths' : FieldValue.increment(-bossDeaths)},
        SetOptions(merge: true),
      );
    }

    await batch.commit();
  }

  Future<void> updateBoss(String uid, String gameId, String bossId,
    String? bossIconPath, String? bossTitle, String? bossSubTitle, int? bossDeaths, bool? isDefeated) async {

    final oldBossSnapshot =  await bossesCollection(uid, gameId).doc(bossId).get();
    BossModel oldBoss = BossModel.fromFirestore(oldBossSnapshot);

    BossModel newBoss = BossModel(
      bossIconPath: (bossIconPath?.isNotEmpty ?? false)? bossIconPath! : oldBoss.bossIconPath,
      bossTitle: (bossTitle?.isNotEmpty ?? false)? bossTitle! : oldBoss.bossTitle,
      bossSubTitle: (bossSubTitle?.isNotEmpty ?? false)? bossSubTitle! : oldBoss.bossSubTitle,
      bossDeaths: (bossDeaths != null)? bossDeaths : oldBoss.bossDeaths,
      isDefeated: (isDefeated != null)? isDefeated : oldBoss.isDefeated,
    );

    final batch = _firestoreInstance.batch();
    batch.set(
      bossesCollection(uid, gameId).doc(bossId),
      newBoss.toFirestore(),
      SetOptions(merge: true),
    );

    final int deltaDeaths = (newBoss.bossDeaths ?? 0) - (oldBoss.bossDeaths ?? 0);

    if(deltaDeaths != 0) {
      batch.set(
        gamesCollection(uid).doc(gameId),
        {'gameDeaths' : FieldValue.increment(deltaDeaths)},
        SetOptions(merge: true),
      );
    }

    await batch.commit();
  }

  Future<void> adjustBossDeaths(String uid, String gameId, String bossId, int deltaDeaths) async {
    if(deltaDeaths == 0) {
      return;
    }
    final batch = _firestoreInstance.batch();

    batch.set(
      bossesCollection(uid, gameId).doc(bossId),
      {'bossDeaths' : FieldValue.increment(deltaDeaths)},
      SetOptions(merge: true),
    );
    batch.set(
      gamesCollection(uid).doc(gameId),
      {'gameDeaths' : FieldValue.increment(deltaDeaths)},
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  Future<void> updateBossDefeated(String uid, String gameId, String bossId, bool isDefeated) async {
    return bossesCollection(uid, gameId).doc(bossId).update({'isDefeated' : isDefeated});
  }

  // Writes sessions
  Future<void> updateSessions(String uid, String gameId, String bossId, BossSession session) =>
    bossesCollection(uid, gameId).doc(bossId).update({'sessions' : FieldValue.arrayUnion([session.toMap()])});
}