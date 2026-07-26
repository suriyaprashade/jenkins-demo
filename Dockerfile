# Step 1: Use the official lightweight Nginx image from Docker Hub
FROM nginx:alpine

# Step 2: Copy custom static website files into the Nginx server directory
COPY index.html /usr/share/nginx/html/index.html

# Step 3: Inform Docker that the container listens on port 80 at runtime
EXPOSE 80

# Note: The official Nginx image automatically handles starting the server, 
# so you do not explicitly need to add a CMD instruction.
