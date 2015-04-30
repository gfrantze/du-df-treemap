If you don't have node.js, download it: http://nodejs.org/download/


Clone this repo


cd du-df-treemap && npm install


To use existing data, skip this step. Otherwise, set your mongodb address, port, and db in connection.js:


module.exports = {

    db: new Db('mydbname', new Server('something.tgen.org', my_port),{safe:true})

};



To generate data*:


nohup bash map_images.sh your_mongodb_address your_port your_desired_db &


*this will take a while, generates data for /liang, /carpten, /ngd-data, /IVY and /su2c... make sure you have access to these directories!




When data generation has finished, or if step was skipped, make sure in /du-df-treemap and:

npm start
