import PackageDescription

let package = Package(
    name: "PuStack_mobile",
    dependencies:[
        .Package(url:"https://github.com/vapor/mysql", majorVersion:1)
    ]
)
