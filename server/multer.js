import multer from 'multer'

const storage = multer.diskStorage({
    destination(req, file, cb) {
        cb(null, '../client/upload/')
    },
    filename(req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname)
    }
})

const types = ['image/png', 'image/jpg', 'image/jpeg']

function fileFilter(req, file, cb) {
    console.log(file)
    if (types.includes(file.mimetype)) {
        cb(null, true)
    } else {
        cb(null, false)
    }
}

export default multer({storage, fileFilter})