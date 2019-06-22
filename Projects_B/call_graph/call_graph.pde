Xml_loader xml_loader;
Parser parser;

String filename = "D:\\Libraries\\Documents\\GitHub\\processing\\Projects_B\\call_graph\\data\\callgraph1.xml";

void setup() {
  xml_loader = new Xml_loader(filename);
  parser = new Parser([filename]);
}

void draw() {
  
}
