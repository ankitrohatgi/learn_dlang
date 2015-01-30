#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <magick/api.h>

int main ( int argc, char **argv )
{
  Image
    *image = (Image *) NULL;

  char
    infile[MaxTextExtent],
    outfile[MaxTextExtent];

  int
    arg = 1,
    exit_status = 0;

  ImageInfo
    *imageInfo;

  ExceptionInfo
    exception;

  InitializeMagick(NULL);
  imageInfo=CloneImageInfo(0);
  GetExceptionInfo(&exception);

  if (argc != 3)
    {
      (void) fprintf ( stderr, "Usage: %s infile outfile\n", argv[0] );
      (void) fflush(stderr);
      exit_status = 1;
      goto program_exit;
    }

  (void) strncpy(infile, argv[arg], MaxTextExtent-1 );
  arg++;
  (void) strncpy(outfile, argv[arg], MaxTextExtent-1 );

  (void) strcpy(imageInfo->filename, infile);
  image = ReadImage(imageInfo, &exception);
  if (image == (Image *) NULL)
    {
      CatchException(&exception);
      exit_status = 1;
      goto program_exit;
    }

  (void) strcpy(image->filename, outfile);
  if (!WriteImage (imageInfo,image))
    {
      CatchException(&image->exception);
      exit_status = 1;
      goto program_exit;
    }

 program_exit:

  if (image != (Image *) NULL)
    DestroyImage(image);

  if (imageInfo != (ImageInfo *) NULL)
    DestroyImageInfo(imageInfo);
  DestroyMagick();

  return exit_status;
}
