If you don't have node.js, download it: http://nodejs.org/download/

Clone this repo

cd du-df-treemap && npm install

modify connection.js with your mongoDb address, port, and desired db such as:

module.exports = {
    db: new Db('mydbname', new Server('something.tgen.org', my_port),{safe:true})
};

to generate data, run python_generate_data/map_images.sh as indicated below (this will take a while, generates data for /liang, /carpten, /ngd-data, /IVY and /su2c)

nohup bash map_images.sh your_mongodb_address your_port your_desired_db &

when that operation has finished, make sure in /du-df-treemap and

npm start
