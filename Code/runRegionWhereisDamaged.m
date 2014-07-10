function runRegionWhereisDamaged
% OT
RegionWhereisDamaged([1:4,6:23],'fa','OT','effect_size')
RegionWhereisDamaged([1:4,6:23],'md','OT','effect_size')
RegionWhereisDamaged([1:4,6:23],'ad','OT','effect_size')
RegionWhereisDamaged([1:4:4,6:23],'rd','OT','effect_size')

RegionWhereisDamaged([1:4,6:23],'fa','OT','minus')
RegionWhereisDamaged([1:4,6:23],'md','OT','minus')
RegionWhereisDamaged([1:4,6:23],'ad','OT','minus')
RegionWhereisDamaged([1:4,6:23],'rd','OT','minus')
% OCF
RegionWhereisDamaged(1:23,'fa','OCF_B','effect_size')
RegionWhereisDamaged(1:23,'md','OCF_B','effect_size')
RegionWhereisDamaged(1:23,'ad','OCF_B','effect_size')
RegionWhereisDamaged(1:23,'rd','OCF_B','effect_size')

RegionWhereisDamaged(1:23,'fa','OCF_B','minus')
RegionWhereisDamaged(1:23,'md','OCF_B','minus')
RegionWhereisDamaged(1:23,'ad','OCF_B','minus')
RegionWhereisDamaged(1:23,'rd','OCF_B','minus')

% OR
RegionWhereisDamaged(1:23,'fa','OR','effect_size')
RegionWhereisDamaged(1:23,'md','OR','effect_size')
RegionWhereisDamaged(1:23,'ad','OR','effect_size')
RegionWhereisDamaged(1:23,'rd','OR','effect_size')

RegionWhereisDamaged(1:23,'fa','OR','minus')
RegionWhereisDamaged(1:23,'md','OR','minus')
RegionWhereisDamaged(1:23,'ad','OR','minus')
RegionWhereisDamaged(1:23,'rd','OR','minus')

