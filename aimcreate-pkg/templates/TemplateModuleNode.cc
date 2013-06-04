#define BUILDING_NODE_EXTENSION
#include <node.h>
#include <TemplateModuleExt.h>

using namespace v8;
using namespace rur;

void RegisterModule(Handle<Object> exports) {
  TemplateModuleExt::NodeRegister(exports);
}

NODE_MODULE(TemplateModule, RegisterModule)