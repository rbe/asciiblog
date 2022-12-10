#!/usr/bin/env bash

# content
for d in assets blog book root
do
    echo -n "Creating content directory content/${d}... "
    mkdir -p "content/${d}"
    echo "done"
done

# content/assets
for d in css fontawesome fonts highlight js
do
    echo -n "Creating content directory content/assets/${d}... "
    mkdir -p "content/assets/${d}"
    echo "done"
done

# content/blog
for d in article
do
    echo -n "Creating content directory content/blog/${d}... "
    mkdir -p "content/blog/${d}"
    echo "done"
done

# content/root
for f in index impressum navigation title
do
    touch "content/root/${f}.adoc"
done

exit 0
