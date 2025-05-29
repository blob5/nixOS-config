{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # color grading
    darktable

    # video editing
    davinci-resolve
  ];
}