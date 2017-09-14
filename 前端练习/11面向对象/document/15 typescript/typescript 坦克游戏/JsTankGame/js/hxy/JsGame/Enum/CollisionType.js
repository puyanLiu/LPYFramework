var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        var Enum;
        (function (Enum) {
            (function (CollisionType) {
                CollisionType[CollisionType["PlayerTank"] = 0] = "PlayerTank";
                CollisionType[CollisionType["EnemyTank"] = 1] = "EnemyTank";
                CollisionType[CollisionType["PlayerShell"] = 2] = "PlayerShell";
                CollisionType[CollisionType["EnemyShell"] = 3] = "EnemyShell";
                CollisionType[CollisionType["Explosion"] = 4] = "Explosion";
                CollisionType[CollisionType["Barrier"] = 5] = "Barrier";
                CollisionType[CollisionType["Grass"] = 6] = "Grass";
            })(Enum.CollisionType || (Enum.CollisionType = {}));
            var CollisionType = Enum.CollisionType;
        })(Enum = JsGame.Enum || (JsGame.Enum = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=CollisionType.js.map