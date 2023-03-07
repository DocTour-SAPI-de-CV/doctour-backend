docker build -t doctour-backend . && docker run -i -t -v "$(pwd)"/:/doctour -p 0.0.0.0:5000:3000 -it doctour-backend

