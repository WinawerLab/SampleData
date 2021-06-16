#! /usr/bin/env python

# Extracts ROIs from atlases in the BIDS directory and writes them to the rois directory

import sys, os, neuropythy as ny, nibabel as nib

subname = sys.argv[1]
print('Processing ROIs for subject %s...' % (subname,))

sub = ny.freesurfer_subject('/subjects/' + subname)
for h in ('lh', 'rh'):
    print('  - %s' % (h.upper(),))
    hem = sub.hemis[h]
    lbl = ny.load('/bids/derivatives/atlases/sub-%s/%s.inferred_varea.mgz' % (subname, h))
    ny.save('/bids/derivatives/rois/sub-%s/%s.inferred_varea.annot' % (subname, h), lbl)

print('Complete!')
