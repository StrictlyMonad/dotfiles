final: prev: {
  git-sync = prev.git-sync.overrideAttrs(_: {
    src = prev.fetchFromGitHub {
      repo = "git-sync";
      owner = "IvanMalison";
      rev = "92544e76553c25da2d40d06a230ecd0a6e13c114";
      sha256 = "sha256-hBtdvxAtFUMtLqGmy1wbDk796LQcYCth29fv8L0WQyQ=";
    };
  });

  picom = prev.picom.overrideAttrs(_: {
    src = prev.fetchFromGitHub {
      repo = "picom";
      owner = "dccsillag";
      rev = "51b21355696add83f39ccdb8dd82ff5009ba0ae5";
      sha256 = "sha256-crCwRJd859DCIC0pEerpDqdX2j8ZrNAzVaSSB3mTPN8==";
    };
  });

  expressvpn = prev.expressvpn.overrideAttrs(_: {
    src = prev.fetchurl {
      url = "https://www.expressvpn.works/clients/linux/expressvpn_3.46.0.7-1_amd64.deb";
      hash = "sha256-v0rr1s32jj79A8IGfJgSGJVlz7rSnZYn4ealOpqee0w=";
    };
  });
}
