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

function ison(obj) {
    if (obj === 'on') {
        return true
    }
    return false
}

export function close(){
    pool.end()
}

//NOTE: gallery
export async function get_all_gallery(){
    const [row] = await pool.query(
        "SELECT gallery.image_gallery, gallery.id_gallery, repertoire.title FROM gallery inner join repertoire using(id_repertoire)",
    )
    return row
}

export async function get_gallery(id){
    const [row] = await pool.query(
        "SELECT image_gallery FROM gallery where id_repertoire = ?",
        [id]
    )
    return row
}

export async function post_gallery(jb){
    await pool.query(
        `INSERT INTO gallery (id_repertoire, image_gallery)
        VALUES (?, ?)`,
        [
            isundefind(jb.id_repertoire),
            isundefind(jb.image)
        ]
    )
}

export async function delete_gallery(id){
    await pool.query(
        `Delete from gallery where id_gallery=?`,
        [
            id
        ]
    )
}

//NOTE: news
export async function get_news(){
    const [row] = await pool.query(`Select * from news`)
    return row
}

//NOTE: awards
export async function get_awards(){
    const [row] = await pool.query(
        `Select * FROM dram.awards`
    )
    return row
}

export async function post_awards(jb){
    const [row] = await pool.query(
        `Insert into awards (image, description)
        VALUES (?,?)`,
        [jb.image, jb.description]
    )
    return row
}

export async function delete_awards(id){
    const [row] = await pool.query(
        `Delete from dram.awards where id_awards = ?`,
        [id]
    )
    return row
}

export async function edite_awards(id, jb){
    if (jb.image){
        await pool.query(
            `UPDATE awards
            SET image = ?
            WHERE id_awards = ?`,
            [
                isundefind(jb.image),
                id
            ]
        )
    }
    await pool.query(
        `UPDATE awards
        SET description = ?
        WHERE id_awards = ?`,
        [
            isundefind(jb.description),
            id
        ]
    )
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
    // let time_create = new Date().toISOString().replace('T',' ').split('.')[0]
    await pool.query(
        `INSERT INTO repertoire (title, author, description, image, duration, creation_time_repertoire)
        VALUES (?, ?, ?, ?, ?, ?)`,
        [
            isundefind(jb.title),
            isundefind(jb.author),
            isundefind(jb.description),
            isundefind(jb.image),
            isundefind(jb.duration),
            isundefind(jb.creation_time_repertoire)
        ]
    )
    const [last_id] = await pool.query(`SELECT LAST_INSERT_ID()`)
    const row = await get_one_repertoire(last_id[0]['LAST_INSERT_ID()'])
    return row
}

export async function delete_repertoire(id){
    const row = await get_one_repertoire(id)
    try{
        await pool.query(
            `DELETE FROM repertoire WHERE id_repertoire = ?`,
            [id]
        )
    }catch (e){
        console.log('нельзя удалить')
    }
    return row
}

export async function edite_repertoire(id,jb){
    if (jb.image){
        await pool.query(
            `UPDATE repertoire
            SET image = ?
            WHERE id_repertoire = ?`,
            [
                isundefind(jb.image),
                id
            ]
        )
    }
    await pool.query(
        `UPDATE repertoire
        SET title = ?, author = ?, description = ?, duration = ?, creation_time_repertoire = ?
        WHERE id_repertoire = ?`,
        [
            isundefind(jb.title),
            isundefind(jb.author),
            isundefind(jb.description),
            isundefind(jb.duration),
            isundefind(jb.creation_time_repertoire),
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
        "SELECT repertoire.*, billboard.* FROM billboard inner join repertoire using(id_repertoire) where id_billboard = ? LIMIT 1",
        [id]
    )
    return row[0]
}

export async function post_billboard(jb){
    await pool.query(
        `INSERT INTO billboard (id_repertoire, date_time, place, src_on_map)
        VALUES (?, ?, ?, ?)`,
        [
            Number(isundefind(jb.id_repertoire)),
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

export async function edite_billboard(id,jb){
    await pool.query(
        `UPDATE dram.billboard
        SET id_repertoire = ?, date_time = ?, place = ?, src_on_map = ?
        WHERE id_billboard = ?`,
        [
            Number(isundefind(jb.id_repertoire)),
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
    const [row] = await pool.query(`SELECT * FROM person`)
    return row
}

export async function get_real_person(){
    const [row] = await pool.query(`SELECT * FROM person where person.real = true`)
    return row
}

export async function get_one_person(id){
    const [row] = await pool.query(
        `SELECT * FROM person where person.id_person = ?`,
        [id]
    )
    return row
}

export async function post_person(jb){
    await pool.query(
        `INSERT INTO person (name, description, birthday, person.real, image)
        VALUES (?, ?, ?, ?, ?)`,
        [
            isundefind(jb.name),
            isundefind(jb.description),
            isundefind(jb.birthday),
            ison(jb.real),
            isundefind(jb.image),
        ]
    )
    const [last_id] = await pool.query(`SELECT LAST_INSERT_ID()`)
    const row = await get_one_person(last_id[0]['LAST_INSERT_ID()'])
    return row
}

export async function delete_person(id){
    const row = await get_one_person(id)
    await pool.query(
        `DELETE FROM person WHERE person.id_person = ?`,
        [id]
    )
    return row
}

export async function edite_person(id,jb){
    if (jb.image){
        await pool.query(
            `UPDATE dram.person
            SET image = ?
            WHERE id_person = ?`,
            [
                isundefind(jb.image),
                id
            ]
        )
    }
    await pool.query(
        `UPDATE dram.person
        SET name = ?, description = ?, birthday = ?, person.real = ?
        WHERE id_person = ?`,
        [
            isundefind(jb.name),
            isundefind(jb.description),
            isundefind(jb.birthday),
            ison(jb.real),
            id
        ]
    )
    const row = await get_one_person(id)
    return row
}

//NOTE: cast
export async function get_all_cast(){
    const [row] = await pool.query(
        `Select person.id_person, repertoire.id_repertoire, person.name, repertoire.title, repertoire.image, cast.role_person, cast.id_cast, cast.is_head from repertoire
        inner join cast on cast.id_repertoire = repertoire.id_repertoire
        inner join person on person.id_person = cast.id_person order by cast.id_repertoire, cast.is_head desc`
    )
    return row
}

export async function post_cast(jb){
    await pool.query(
        `INSERT INTO dram.cast (id_person, id_repertoire, role_person, is_head)
        VALUES (?, ?, ?, ?)`,
        [
            Number(isundefind(jb.id_person)),
            Number(isundefind(jb.id_repertoire)),
            isundefind(jb.role_person),
            ison(jb.is_head)
        ]
    )
}

export async function delete_cast(id){
    await pool.query(
        `delete from dram.cast where cast.id_cast = ?`,
        [id]
    )
}

export async function edite_cast(id,jb){
    await pool.query(
        `UPDATE dram.cast
        SET id_person = ?, id_repertoire = ?, role_person = ?, is_head = ?
        WHERE id_cast = ?`,
        [
            isundefind(jb.id_person),
            isundefind(jb.id_repertoire),
            isundefind(jb.role_person),
            ison(jb.is_head),
            id
        ]
    )
}

export async function get_cast_for(id){
    const [row] = await pool.query(
        `Select person.name, person.id_person, cast.role_person, cast.id_cast from repertoire
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