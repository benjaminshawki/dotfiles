`db.restaurants.find().sort({name: 1})
db.restaurants.find({cuisine: "Irish"})
db.restaurants.find({cuisine: "Chinese", borough: "Queens"})
db.restaurants.find({"grades.score" {$gt: 90}})` 


