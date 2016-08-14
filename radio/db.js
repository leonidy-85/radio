function jobDB() {
    var db = LocalStorage.openDatabaseSync("radio.db", "1.0", "radio DataBase", 100000);


    db.transaction(
                function(tx) {

                    tx.executeSql("CREATE TABLE IF NOT EXISTS radio(name TEXT, ip TEXT, descripcion TEXT)");

                    var rs = tx.executeSql("SELECT * FROM radio");


                    if (rs.rows.length <= 0) {


                        //                tx.executeSql('INSERT INTO radio VALUES(?, ?, ?)', ["Hall", "192.168.1.10", "test"]);
                        //                tx.executeSql('INSERT INTO radio VALUES(?, ?, ?)', ["Bedroom", "192.168.1.11", ""]);



                        var rs = tx.executeSql('SELECT * FROM radio ORDER BY name ASC');
                    }

                    var index = 0;
                    if (rs.rows.length > 0) {
                        var index = 0;
                        while (index <rs.rows.length) {
                            var unidad = rs.rows.item (index);
                            dbprimary.append ({
                                                  "name": unidad.name,
                                                  "ip": unidad.ip,
                                                  "descripcion": unidad.descripcion});
                            index ++;
                        }
                    }
                }
                )
}

//Добавить новое значение в БД
function insert(name, ip, descripcion) {
    var db = LocalStorage.openDatabaseSync("radio.db", "1.0", "radio DataBase", 100000);

    db.transaction(
                function(tx) {
                    // Создание таблицы если она не существует:
                    tx.executeSql("CREATE TABLE IF NOT EXISTS radio(name TEXT, ip TEXT, descripcion TEXT)");

                    // Создание дб
                    tx.executeSql('INSERT INTO radio VALUES(?, ?, ?)', [name, ip, descripcion]);
                }
                )
}


function del(name) {
    var db = LocalStorage.openDatabaseSync("radio.db", "1.0", "radio DataBase", 100000);

    db.transaction(
                function(tx) {
                    // Удалить по имени:
                    tx.executeSql('DELETE FROM radio WHERE name = ?',[name]);
                }
                )
}

//Функция записи по имени
function recoger(name) {
    var db = LocalStorage.openDatabaseSync("radio.db", "1.0", "radio DataBase", 100000);
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT * FROM radio WHERE name = ?',[name]);
                    var unidad = rs.rows.item (0);

                    radio.append ({
                                    "ip": unidad.ip,
                                    "descripcion": unidad.descripcion});
                }
                )
}


function onradio(st,channel) {

    var source = dbprimary.get(channel).ip
    //  console.log('on')


    switch(st){
    case 0:
        //console.log(qr)
 playMusic.play();
        break
    case 1:
        console.log(source)

        break
    }

}



