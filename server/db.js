import mysql from 'mysql2'

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'mysql',
    database: 'dram'
}).promise()



function isundefind(obj) {
    if (obj === undefined || obj === '') {
        return null
    }
    return obj
}


//NOTE: repertoire 
export async function get_all_repertoire(){
    const [row] = await pool.query("SELECT * FROM repertoire")
    return row
}

export async function get_all_repertoire_new(){
    const [row] = await pool.query("SELECT * FROM repertoire ORDER BY creation_time_repertoire DESC")
    return row
}

export async function get_one_repertoire(id){
    const [row] = await pool.query(
        "SELECT * FROM repertoire WHERE id_repertoire = ? LIMIT 1",
        [id]
    )

    return row[0]
}

export async function post_repertoire(jb){
    let time_create = new Date().toISOString().replace('T',' ').split('.')[0]
    await pool.query(
        `INSERT INTO repertoire (title, author, description, image, duration, creation_time_repertoire)
        VALUES (?, ?, ?, ?, ?, ?)`,
        [
            isundefind(jb.title),
            isundefind(jb.author),
            isundefind(jb.description),
            isundefind(jb.image),
            isundefind(jb.duration),
            time_create
        ]
    )
    const [last_id] = await pool.query(`SELECT LAST_INSERT_ID()`)
    const row = await get_one_repertoire(last_id[0]['LAST_INSERT_ID()'])
    return row
}

export async function delete_repertoire(id){
    const row = await get_one_repertoire(id)
    await pool.query(
        `DELETE FROM repertoire WHERE id_repertoire = ?`,
        [id]
    )
    return row
}

export async function update_repertoire(id,jb){
    await pool.query(
        `UPDATE repertoire
        SET title = ?, author = ?, description = ?, image = ?, duration = ?
        WHERE id_repertoire = ?`,
        [
            isundefind(jb.title),
            isundefind(jb.author),
            isundefind(jb.description),
            isundefind(jb.image),
            isundefind(jb.duration),
            id
        ]
    )
    const row = await get_one_repertoire(id)
    return row
}

//NOTE: billboard 
export async function get_all_billboard(){
    const [row] = await pool.query("SELECT repertoire.*, billboard.* FROM billboard inner join repertoire using(id_repertoire) ORDER BY billboard.date_time")
    return row
}

export async function get_one_billboard(id){
    const [row] = await pool.query(
        "SELECT repertoire.*, billboard.* FROM billboard inner join repertoire using(id_repertoire) where id_billboard = ?",
        [id]
    )
    return row[0]
}

export async function post_billboard(jb){
    await pool.query(
        `INSERT INTO billboard (id_repertoire, date_time, place, src_on_map)
        VALUES (?, ?, ?, ?)`,
        [
            isundefind(jb.id_repertoire),
            isundefind(jb.date_time),
            isundefind(jb.place),
            isundefind(jb.src_on_map)
        ]
    )
    const [last_id] = await pool.query(`SELECT LAST_INSERT_ID()`)
    const row = await get_one_billboard(last_id[0]['LAST_INSERT_ID()'])
    return row
}

export async function delete_billboard(id){
    const row = await get_one_billboard(id)
    await pool.query(
        `DELETE FROM billboard WHERE id_billboard = ?`,
        [id]
    )
    return row
}

export async function update_billboard(id,jb){
    await pool.query(
        `UPDATE billboard
        SET id_repertoire = ?, date_time = ?, place = ?, src_on_map = ?
        WHERE id_billboard = ?`,
        [
            isundefind(jb.id_repertoire),
            isundefind(jb.date_time),
            isundefind(jb.place),
            isundefind(jb.src_on_map),
            id
        ]
    )
    const row = await get_one_billboard(id)
    return row
}

//NOTE: person
export async function get_all_person(){
    const [row] = await pool.query(`SELECT * FROM person where person.real = true`)
    return row
}


//NOTE: cast
export async function get_cast_for(id){
    const [row] = await pool.query(
        `Select person.name, cast.role_person, cast.id_cast from repertoire
        inner join cast on cast.id_repertoire = repertoire.id_repertoire
        inner join person on person.id_person = cast.id_person where repertoire.id_repertoire = ? and is_head = false`,
        [id]
    )
    return row
}

export async function get_cast_head_for(id){
    const [row] = await pool.query(
        `Select person.name, cast.role_person, cast.id_cast from repertoire
        inner join cast on cast.id_repertoire = repertoire.id_repertoire
        inner join person on person.id_person = cast.id_person where repertoire.id_repertoire = ? and is_head = true`,
        [id]
    )
    return row
}


let jb = {
    title: 'asd',
    author: 'asdsssssssssssssssssss',
    description: 'asd',
    image: 'asd',
    duration: 'asd2'
}

let jb1 = {
    id_repertoire: 1,
    date_time: '2023-08-27 15:15:00',
    place: 'ул. Ленина 78, Квартал',
    src_on_map: "http://a",
}