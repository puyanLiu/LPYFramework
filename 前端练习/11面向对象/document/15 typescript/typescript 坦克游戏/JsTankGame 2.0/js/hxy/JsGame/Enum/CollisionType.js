var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        var Enum;
        (function (Enum) {
            (function (CollisionType) {
                CollisionType[CollisionType["PlayerTank"] = 1] = "PlayerTank";
                CollisionType[CollisionType["EnemyTank"] = 2] = "EnemyTank";
                CollisionType[CollisionType["PlayerShell"] = 4] = "PlayerShell";
                CollisionType[CollisionType["EnemyShell"] = 8] = "EnemyShell";
                CollisionType[CollisionType["Explosion"] = 16] = "Explosion";
                CollisionType[CollisionType["Barrier"] = 32] = "Barrier";
                CollisionType[CollisionType["Grass"] = 64] = "Grass";
            })(Enum.CollisionType || (Enum.CollisionType = {}));
            var CollisionType = Enum.CollisionType;
        })(Enum = JsGame.Enum || (JsGame.Enum = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=CollisionType.js.map