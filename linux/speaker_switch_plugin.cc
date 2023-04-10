#include "include/speaker_switch/speaker_switch_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define SPEAKER_SWITCH_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), speaker_switch_plugin_get_type(), \
                              SpeakerSwitchPlugin))

struct _SpeakerSwitchPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(SpeakerSwitchPlugin, speaker_switch_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void speaker_switch_plugin_handle_method_call(
    SpeakerSwitchPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getPlatformVersion") == 0) {
    struct utsname uname_data = {};
    uname(&uname_data);
    g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
    g_autoptr(FlValue) result = fl_value_new_string(version);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void speaker_switch_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(speaker_switch_plugin_parent_class)->dispose(object);
}

static void speaker_switch_plugin_class_init(SpeakerSwitchPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = speaker_switch_plugin_dispose;
}

static void speaker_switch_plugin_init(SpeakerSwitchPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  SpeakerSwitchPlugin* plugin = SPEAKER_SWITCH_PLUGIN(user_data);
  speaker_switch_plugin_handle_method_call(plugin, method_call);
}

void speaker_switch_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  SpeakerSwitchPlugin* plugin = SPEAKER_SWITCH_PLUGIN(
      g_object_new(speaker_switch_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "speaker_switch",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
