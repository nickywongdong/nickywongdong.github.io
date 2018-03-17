odule.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getPlanets(res, mysql, context, complete){
        mysql.pool.query("SELECT id, name FROM planet", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.planets  = results;
            complete();
        });
    }

    function getGuardians(res, mysql, context, complete){
        mysql.pool.query("SELECT guardian.id, guardian.name, planet.name AS current_planet, level, class, race FROM guardian INNER JOIN planet ON current_planet = planet.id", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.people = results;
            complete();
        });
    }

    function getGuardian(res, mysql, context, id, complete){
        var sql = "SELECT id, name, class, race, level FROM guardian WHERE id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.person = results[0];
            complete();
        });
    }

    /*Displays all guardians. Requires web based javascript to delete users with AJAX*/

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteguardian.js"];
        var mysql = req.app.get('mysql');
        getGuardians(res, mysql, context, complete);
        getPlanets(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('guardian', context);
            }

        }
    });

    /* Display one guardian for the specific purpose of updating guardian */

    router.get('/:id', function(req, res){
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selectedplanet.js", "updateguardian.js"];
        var mysql = req.app.get('mysql');
        getPerson(res, mysql, context, req.params.id, complete);
        getPlanets(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('update-guardian', context);
            }

        }
    });

    /* Adds a guardian, redirects to the guardian page after adding */

    router.post('/', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO guardian (name, class, race, level) VALUES (?,?,?,?)";
        var inserts = [req.body.name, req.body.class, req.body.race, req.body.level];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/guardian');
            }
        });
    });

    /* The URI that update data is sent to in order to update a guardian */

    router.put('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "UPDATE guardian SET name=?, class=?, race=?, current_planet=?, level=? WHERE id=?";
        var inserts = [req.body.name, req.body.class, req.body.race, req.body.current_planet, req.body.level, req.params.id];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.status(200);
                res.end();
            }
        });
    });

    /* Route to delete a guardian, simply returns a 202 upon success. Ajax will handle this. */

    router.delete('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM guardian WHERE id = ?";
        var inserts = [req.params.id];
        sql = mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.status(400);
                res.end();
            }else{
                res.status(202).end();
            }
        })
    })

    return router;
}();
