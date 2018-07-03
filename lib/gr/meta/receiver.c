#include <stdio.h>

#include "gr.h"


int test_recvmeta(void) {
  gr_meta_args_t *args;
  void *handle;

  printf("waiting for data... ");
  fflush(stdout);

  handle = gr_openmeta(GR_SOURCE_SOCKET, "localhost", 8002);
  if (handle == NULL) {
    fprintf(stderr, "receiver could not be created\n");
    return 1;
  }

  if ((args = gr_recvmeta(handle, NULL)) == NULL) {
    gr_meta_args_delete(args);
    return 2;
  }

  printf("received\n");
  gr_dumpmeta(args, stdout);
  printf("\njson dump:\n");
  gr_dumpmeta_json(args, stdout);

  gr_closemeta(handle);
  gr_meta_args_delete(args);

  return 0;
}

int main(void) {
  return test_recvmeta();
}
