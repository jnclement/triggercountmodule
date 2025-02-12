int checks(string filename)
{

  cout << endl << endl << endl << "BEGIN!" << endl;
  TFile* file = TFile::Open(filename.c_str());
  TTree* tree = (TTree*)file->Get("outt");

  long long unsigned int totlive[64];
  long long unsigned int totscaled[64];
  long long unsigned int sumgoodscaled[64];
  long long unsigned int sumgoodlive[64];
  double avgPS[64];
  long long unsigned int tottrigcounts[3][64];
  double totembdlive[3];
  long long unsigned int nevt;

  tree->SetBranchAddress("totlive",totlive);
  tree->SetBranchAddress("totscaled",totscaled);
  tree->SetBranchAddress("sumgoodscaled",sumgoodscaled);
  tree->SetBranchAddress("sumgoodlive",sumgoodlive);
  tree->SetBranchAddress("avgPS",avgPS);
  tree->SetBranchAddress("tottrigcounts",tottrigcounts);
  tree->SetBranchAddress("totembdlive",totembdlive);
  tree->SetBranchAddress("nevt",&nevt);

  tree->GetEntry(0);

  cout << "Begin infodump for file: " << filename << endl;
  cout << "total produced events in run: " << nevt << endl;
  cout << "upscaled mbd evt. w/ |zvtx| < 30/60/200: " << totembdlive[0] << " " << totembdlive[1] << " " << totembdlive[2] << endl;
  for(int i=0; i<64; ++i)
    {
      cout << "trigger " << i << endl;
      cout << "live counts (last - first): " << totlive[i] << endl;
      cout << "live counts (good segs): " << sumgoodlive[i] << endl;
      cout << "scaled counts (last - first): " << totscaled[i] << endl;
      cout << "scaled counts (good segs): " << sumgoodscaled[i] << endl;
      cout << "average prescale (good segs): " << avgPS[i] << endl;
      cout << "tot. prod. evt. w/ bit " << i << " up: " << endl;
      cout << "|zvtx| < 30/60/200 cm: " << tottrigcounts[0][i] << " " << tottrigcounts[1][i] << " " << tottrigcounts[2][i] << endl;
      
    }
  cout << "DONE!" << endl << endl << endl;
  return 0;
}
