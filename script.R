library(igraph)

# Load adjacency matrix
print("Loading adjacency matrix...")
adjm <- read.csv("adjacency-matrix.tsv", header=T, row.names = 1, sep='\t')
adjm <- as.matrix(adjm)

#iGraph can create graph objects from different sources like data.frame, edge.list, or from adjacency.matrix.
#The function graph.adjacency creates a graph object from adjacency matrix. Weight here represents the level of correlation.
print("Creating graph object...")
net.grph=graph.adjacency(adjm,mode="undirected",weighted=TRUE,diag=FALSE)

#Obtaining edge weight based on the Spearman correlation
print("Obtaining edge weight based on the Spearman correlation...")
edgew<-E(net.grph)$weight

#Creating a vector to remove the isolated nodes (nodes with no interactions)
print("Creating a vector to remove the isolated nodes (nodes with no interactions)...")
bad.vs<-V(net.grph)[degree(net.grph) == 0] 

#Removing the isolated nodes from the graph object using the function delete.vertices()
print("Removing the isolated nodes from the graph object...")
net.grph <-delete.vertices(net.grph, bad.vs)

# Save graph object
print("Saving graph object as gml...")
write.graph(net.grph,'co-occurrence-graph.gml',format='gml')

#Networks are plotted with the function plot()from iGraph.
#plot(net.grph,
#    vertex.size=8,
#    vertex.frame.color="black",
#    edge.curved=F,
#    edge.width=1.5,
#    layout=layout.fruchterman.reingold,
#    edge.color=ifelse(edgew < 0,"red","blue"),
#    vertex.label=NA,
#    vertex.label.color="black",
#    vertex.label.family="Times New Roman",
#    vertex.label.font=2)

#If you want to have a network with node labeled, removed  vertex.label=NA,

# Save image as pdf
print("Saving network image as SVG...")
svg("network.svg")

plot(net.grph,
    vertex.size=8,
    vertex.frame.color="black",
    edge.curved=F,
    edge.width=1,
    layout=layout.fruchterman.reingold,
    edge.color=ifelse(edgew < 0,"red","blue"),
    vertex.label.color="black",
    vertex.label.family="ArialMT",
    vertex.label.font=0.1) 

dev.off()

print("Done.")
###From:https://kelseyandersen.github.io/NetworksPlantPathology/Microbiome_network_ICPP2018_v2.html#network_analysis###
