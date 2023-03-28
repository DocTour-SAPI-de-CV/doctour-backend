docker build -t doctour-backend . && docker run -i -t -v "$(pwd)"/:/doctour -p 0.0.0.0:5000:3000 -it doctour-backend

# docker run -i -t -p 0.0.0.0:5000:3000 -it 432968470264.dkr.ecr.us-east-2.amazonaws.com/doctour-api-dev