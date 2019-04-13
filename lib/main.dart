import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'PHE Infections in Primary Care app',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
        ),
        //Home Screen
        home: InfectionGroupsScreen(),
      );
}

//Infection Groups Screen Code
class InfectionGroupsScreen extends StatefulWidget {
  @override
  createState() => InfectionGroupsScreenState();
}

class InfectionGroupsScreenState extends State<InfectionGroupsScreen> {
  final _infectionGroupsList = guideline.keys.toList(); //assigning groups
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Infection Groups'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/UCLAN.png'),
                      fit: BoxFit.contain
                  )
              ),
            ),
            _buildInfectionGroupsList(),
          ]
        )
    );
  }

  Widget _buildInfectionGroupsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return Divider(
            color: Colors.red,
          );
        final index = i ~/ 2;
        return _buildRow(_infectionGroupsList[index]);
      },
      // Count doubled as adding Divider
      itemCount: _infectionGroupsList.length * 2,
    );
  }

  Widget _buildRow(item) {
    return ListTile(
      title: Text(
        item,
        style: _biggerFont,
      ),
      onTap: () {
        group = guideline[item]; //assigning chosen group
        title = item.toString(); //title of group
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InfectionsScreen()));
      },
    );
  }
}

// Infections Screen code
class InfectionsScreen extends StatefulWidget {
  @override
  createState() => InfectionsScreenState();
}

class InfectionsScreenState extends State<InfectionsScreen> {
  final _infectionsList = group.keys.toList(); // pick map keys of group
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/UCLAN.png'),
                      fit: BoxFit.contain)),
            ),
            _buildInfectionsList(),
          ],
        ));
  }

  Widget _buildInfectionsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return Divider(
            color: Colors.red,
          );
        final index = i ~/ 2;
        return _buildRow(_infectionsList[index]);
      },
      // Count doubled as adding Divider
      itemCount: _infectionsList.length * 2,
    );
  }

  Widget _buildRow(item) {
    return ListTile(
      title: Text(
        item,
        style: _biggerFont,
      ),
      onTap: () {
        guidanceMasterList = []; //Erase master list
        title = item.toString(); //title
        infection = group[item]; //assigning chosen infection
        guidanceKeys = infection.keys.toList();
        for (var listForKey in guidanceKeys) {
          guidanceMasterList.add('keyItem');
          guidanceMasterList.add(listForKey);
          for (var item in infection[listForKey]) {
            guidanceMasterList.add('listItem');
            guidanceMasterList.add(item);
          }
        }
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InfectionScreen()));
      },
    );
  }
}

class InfectionScreen extends StatefulWidget {
  @override
  createState() => InfectionScreenState();
}

class InfectionScreenState extends State<InfectionScreen> {
  final _biggerFont = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white);
  final _smallerFont = const TextStyle(fontSize: 16.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/UCLAN.png'),
                      fit: BoxFit.contain)),
            ),
            _buildGuidanceList(),
          ],
        ));
  }

  Widget _buildGuidanceList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return Divider(
            color: Colors.red,
          );
        var index = i ~/ 2;
        if (guidanceMasterList[i] == 'keyItem') {
          return _buildRowBold(guidanceMasterList[i + 1]);
        }
        if (guidanceMasterList[i] == 'listItem') {
          return _buildRow(guidanceMasterList[i + 1]);
        }
      },
      // Count doubled as adding Divider
      itemCount: guidanceMasterList.length,
    );
  }

  Widget _buildRowBold(item) {
    return Container(
        decoration: BoxDecoration(color: Colors.red),
        child: ListTile(
          title: Text(
            item,
            style: _biggerFont,
          ),
        ));
  }

  Widget _buildRow(item) {
    return ListTile(
      title: Text(
        item,
        style: _smallerFont,
      ),
    );
  }
}

const guideline = {
  'Upper respiratory tract infections': {
    'Acute sore throat': {
      'Use FeverPAIN score or Centor': [
        '(Fever) in last 24 hours                 -> 1',
        '(P)urulence                                  -> 1',
        '(A)ttend rapidly under three days  -> 1',
        'severely (I)nflamed tonsils            -> 1',
        '(N)o cough or coryza                     -> 1'
      ],
      'Key points': [
        'FeverPAIN 0-1 or Centor 0-2: no antibiotic;',
        'FeverPAIN 2-3: no or back-up antibiotic;',
        'FeverPAIN 4-5 or Centor 3-4: immediate or back-up antibiotic;',
        'Systemically very unwell or high risk of complications: immediate antibiotic.',
        'Advise paracetamol, or if preferred and suitable, ibuprofen for pain.',
        'Medicated lozenges may help pain in adults.'
      ],
      'Treatment': [
        'FIRST CHOICE: Phenoxymethylpenicillin 500mg QDS OR 1g BD for 5-10 days.',
        'Penicillin allergy: Clarithromycin 250mg to 500mg BD for 5 days.',
        'OR',
        'Erythromycin (preferred if pregnant) 250-500mg QDS (or 500mg to 1000mg BD) for 5 days.',
        'Check BNF for interactions, cautions and child doses.'
      ]
    },
    'Influenza': {
      'At risk patients': [
        'pregnant (including up to two weeks post-partum)',
        'children under six months',
        'adults 65 years or older',
        'chronic respiratory disease (including COPD and asthma)',
        'significant cardiovascular disease (not hypertension)',
        'severe immunosuppression',
        'diabetes mellitus',
        'chronic neurological, renal or liver disease',
        'morbid obesity (BMI>40)'
      ],
      'Annual vaccination': [
        'Annual vaccination is essential for all those “at risk” of influenza.'
      ],
      'Treatment': [
        'Antivirals are not recommended for healthy adults.',
        'Treat “at risk” patients with five days oseltamivir 75mg BD ideally within 48 hours of onset (36 hours for zanamivir treatment in children) or in a care home where influenza is likely.',
        'See the PHE Influenza guidance for the treatment of patients under 13 years of age.',
        'In severe immunosuppression, or oseltamivir resistance, use zanamivir 10mg BD (2 inhalations twice daily by diskhaler for up to 10 days) and seek advice.',
        'Check BNF for interactions, cautions and child doses.'
      ],
    },
    'Scarlet fever (GAS)': {
      'Key points': [
        'Prompt treatment with appropriate antibiotics significantly reduces the risk of complications.',
        'Vulnerable individuals (immunocompromised, the comorbid, or those with skin disease) are at increased risk of developing complications.'
      ],
      'Treatment': [
        'Optimise analgesia and give safety netting advice.',
        'Phenoxymethylpenicillin 500mg QDS for 10 days.',
        'Penicillin allergy: Clarithromycin 250 to 500mg BD for 5 days.',
        'Check BNF for interactions, cautions and child doses.'
      ]
    },
    'Acute otitis media': {
      'Key points': [
        'Regular paracetamol or ibuprofen for pain (right dose for age or weight at the right time and maximum doses for severe pain). ',
        'Otorrhoea or under 2 years with infection in both ears: no, back-up or immediate antibiotic.',
        'Otherwise: no or back-up antibiotic.',
        'Systemically very unwell or high risk of complications: immediate antibiotic.'
      ],
      'Treatment': [
        'FIRST CHOICE: Amoxicillin for 5 to 7 days days',
        'Penicillin allergy: Clarithromycin OR Erythromycin (preferred if pregnant) for 5 to 7 days',
        'SECOND CHOICE: co-amoxiclav for 5 to 7 days.',
        'Check BNF for interactions, cautions and doses.'
      ]
    },
    'Acute otitis externa': {
      'Key points': [
        'FIRST LINE: analgesia for pain relief and apply localised heat (eg a warm flannel).',
        'SECOND LINE: topical acetic acid or topical antibiotic +/- steroid: similar cure at 7 days.',
        'If cellulitis or disease extends outside ear canal, or systemic signs of infection, start oral flucloxacillin and refer to exclude malignant otitis externa.'
      ],
      'Treatment': [
        'SECOND LINE: topical acetic acid 2% 1 spray TDS for 7 days',
        'OR',
        'Topical neomycin sulphate with corticosteroid 3 drops tds minimum 7 days to maximum 14 days.',
        'If cellulitis: flucloxacillin 250mg QDS (If severe: 500mg QDS) for 7 days.',
        'Check BNF for interactions, cautions and child doses.'
      ]
    },
    'Sinusitis': {
      "Self-care": [
        'Advise paracetamol or ibuprofen for pain.',
        'Little evidence that nasal saline or nasal decongestants help, but people may want to try them.'
      ],
      'Symptoms for 10 days or less': [
        'No antibiotic.'
      ],
      'Symptoms with no improvement for more than 10 days': [
        'no antibiotic,',
        'or back-up antibiotic depending on likelihood of bacterial cause.',
        'Consider high-dose nasal corticosteroid (if over 12 years).',
      ],
      'Systemically very unwell or high risk of complications': [
        'Immediate antibiotic.',
      ],
      'Antibiotic treatment': [
        'FIRST CHOICE: phenoxymethylpenicillin 500mg QDS for 5 days.',
        'Penicillin allergy: doxycycline (not in under 12s) 200mg on day 1 then 100mg OD for 5 days.',
        'OR',
        'Clarithromycin 500mg BD for 5 days.',
        'OR',
        'erythromycin (preferred if pregnant) 250mg to 500mg QDS or 500mg to 1000mg BD for 5 days.',
        'SECOND CHOICE: or if systemically very unwell or high risk of complications: co-amoxiclav 500/125mg TDS for 5 days.'
      ]
    },
  },
  'Lower respiratory tract infections': {
    'Acute exacerbation of COPD': {
      'Key points': [
        'Many exacerbations are not caused by bacterial infections so will not respond to antibiotics.',
        'Consider an antibiotic, but only after taking into account severity of symptoms (particularly sputum colour changes and increases in volume or thickness), need for hospitalisation, previous exacerbations, hospitalisations and risk of complications, previous sputum culture and susceptibility results, and risk of resistance with repeated courses.',
        'Some people at risk of exacerbations may have antibiotics to keep at home as part of their exacerbation action plan.',
        'Low doses of penicillins are more likely to select for resistance. Do not use fluoroquinolones (ciprofloxacin, ofloxacin) first line because they may have long-term side effects and there is poor pneumococcal activity.',
        ' Reserve all fluoroquinolones (including levofloxacin) for proven resistant organisms.'
      ],
      'Treatment': [
        'FIRST CHOICE:',
        'Amoxicillin 500mg TDS for 5 days.',
        'OR',
        'Doxycycline 200mg on day 1 then 100mg OD for 5 days.',
        'OR',
        'Clarithromycin 500mg BD for 5 days.',
        '-----------------------------------------------------',
        'SECOND CHOICE:',
        'Use alternative first choice.',
        '-----------------------------------------------------',
        'ALTERNATIVE CHOICE (if person at higher risk of treatment failure):',
        'Co-amoxiclav 500/125mg TDS for 5 days.',
        'OR',
        'Levofloxacin (consider safety issues) 500mg OD for 5 days.',
        'OR',
        'Co-trimoxazole (consider safety issues) 960mg BD for 5 days.',
        '-----------------------------------------------------',
        'IV antibiotics: See full guideline for details.',
        'Check BNF for interactions, cautions and child doses.'
      ]
    },
    'Acute cough': {
      'Key points': [
        'Some people may wish to try honey (in over 1s),',
        'the herbal medicine pelargonium (in over 12s),',
        'cough medicines containing the expectorant guaifenesin (in over 12s) or cough medicines containing cough suppressants, except codeine, (in over 12s).',
        'These self-care treatments have limited evidence for the relief of cough symptoms. ',
        'Acute cough with upper respiratory tract infection: no antibiotic.',
        'Acute bronchitis: no routine antibiotic.',
        'Acute cough and higher risk of complications (at face-to-face examination): immediate or backup antibiotic.',
        'Acute cough and systemically very unwell (at face to face examination): immediate antibiotic.',
        'Higher risk of complications includes people with pre-existing comorbidity; young children born prematurely; people over 65 with 2 or more of, or over 80 with 1 or more of: hospitalisation in previous year, type 1 or 2 diabetes, history of congestive heart failure, current use of oral corticosteroids.',
        'Do not offer a mucolytic, an oral or inhaled bronchodilator, or an oral or inhaled corticosteroid unless otherwise indicated.',
        'See also the NICE guideline on pneumonia for prescribing antibiotics in adults with acute bronchitis who have had a C-reactive protein (CRP) test (CRP<20mg/l: no routine antibiotic, CRP 20 to 100mg/l: back-up antibiotic, CRP>100mg/l: immediate antibiotic).',
        'Low doses of penicillins are more likely to select for resistance. Do not use fluoroquinolones (ciprofloxacin, ofloxacin) first line because they may have long-term side effects and there is poor pneumococcal activity.',
        ' Reserve all fluoroquinolones (including levofloxacin) for proven resistant organisms.'
      ],
      'Antibiotic Treatment': [
        'ADULTS FIRST CHOICE: Doxycycline 200mg on day 1, then 100mg OD for 5 days.',
        'ADULTS ALTERNATIVE FIRST CHOICE: Amoxicillin 500mg TDS for 5 days',
        'OR',
        'Clarithromycin 250mg to 500mg BD for 5 days',
        'OR',
        'Erythromycin (preferred if pregnant) 250mg to 500mg QDS or 500mg to 1000mg BD.',
        'CHILDREN FIRST CHOICE:',
        'Amoxicillin for 5 days.',
        'CHILDREN ALTERNATIVE CHOICES:',
        'Clarithromycin for 5 days,',
        'OR',
        'Erythromycin for 5 days,',
        'OR',
        'Doxycycline (not under 12s) for 5 days.',
        'Check BNF for interactions, cautions and child doses.'
      ]
    },
    'Community acquired pneumonia': {
      'Good practice points': [
        'Give safety-net advice1D and likely duration of different symptoms, eg cough 6 weeks.',
        'Clinically assess need for dual therapy for atypicals',
        'Mycoplasma infection is rare in over 65s.',
        'Note: Low doses of penicillins are more likely to select for resistance.',
        'Low doses of penicillins are more likely to select for resistance. Do not use fluoroquinolones (ciprofloxacin, ofloxacin) first line because they may have long-term side effects and there is poor pneumococcal activity.',
        ' Reserve all fluoroquinolones (including levofloxacin) for proven resistant organisms.'
      ],
      'Use CRB65 score': [
        'to guide mortality risk, place of care, and antibiotics. Each CRB65 parameter scores one.',
        '(C)onfusion (AMT<8 or new disorientation in person, place or time)',
        '(R)espiratory rate >30/min',
        '(B)P systolic <90, or diastolic <60',
        'age over (65)',
      ],
      'Treatment': [
        'CRB65 Score 0: low risk,',
        'Consider home-based care with either:',
        'Amoxicillin 500mg TDS for 5 days, review at 3 days; 7-10 if poor response.',
        'OR',
        'Doxycycline 200mg stat then 100mg OD for 5 days, review at 3 days; 7-10 if poor response.',
        'OR',
        'Clarithromycin 500mg BD for 5 days, review at 3 days; 7-10 if poor response.',
        'CRB65 Score 1-2: intermediate risk',
        'Treated at home: Clinically assess need for dual therapy for atypicals:',
        'Amoxicillin 500mg TDS for 7-10 days,',
        'AND',
        'Clarythromycin 500mg BD for 7-10 days.',
        'OR',
        'Doxycycline alone, 200mg stat then 100mg OD for 7-10 days.',
        'Check BNF for interactions, cautions and child doses.'
      ]
    },
  },
  'Urinary tract infections': {
    'Lower UTI in adults': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'UTI in patients with catheters': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'UTI in pregnancy': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Acute prostatitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'UTI in children': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Acute pyelonephritis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Recurrent UTI in non-pregnant women': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
  },
  'Meningitis': {
    'Suspected meningococcal disease': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Preventionof secondary case of meningitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
  },
  'Gastrointestinal tract infections': {
    'Oral candidiasis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Helicobacter pylori': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Infectious diarrhoea': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Clostridium difficile': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Traveller’s diarrhoea': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Threadworm': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
  },
  'Genital tract infections': {
    'STI screening': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Chlamydia trachomatis/ urethritis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Epididymitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Vaginal candidiasis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Bacterial vaginosis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Genital herpes': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Gonorrhoea': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Trichomoniasis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Pelvic inflammatory disease': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
  },
  'Skin and soft tissue infections': {
    'Impetigo': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Cold sores': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'PVL-SA': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Eczema': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Acne': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Cellulitis and erysipelas': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Leg ulcer': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Bites': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Scabies': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Mastitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Dermatophyte infection: skin': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Dermatophyte infection: nail': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Varicella zoster/ chickenpox': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Herpes zoster/ shingles': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
  },
  'Eye infections': {
    'Conjunctivitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Blepharitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
  },
  'Dental infections': {
    'Mucosal ulceration and inflammation (simple gingivitis)': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Acute necrotising ulcerative gingivitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Pericoronitis': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
    'Dental abscess': {
      '': ['', '', 'Check BNF for interactions, cautions and child doses.']
    },
  }
};

var group = Map();
var infection = Map();
var guidanceKeys = List();
var guidanceMasterList = List();
var title;

void main() => runApp(MyApp());
