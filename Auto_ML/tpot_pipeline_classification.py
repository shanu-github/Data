import numpy as np
import pandas as pd
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.linear_model import SGDClassifier
from sklearn.model_selection import train_test_split
from sklearn.pipeline import make_pipeline, make_union
from tpot.builtins import StackingEstimator
from tpot.export_utils import set_param_recursive

# NOTE: Make sure that the outcome column is labeled 'target' in the data file
tpot_data = pd.read_csv('PATH/TO/DATA/FILE', sep='COLUMN_SEPARATOR', dtype=np.float64)
features = tpot_data.drop('target', axis=1)
training_features, testing_features, training_target, testing_target = \
            train_test_split(features, tpot_data['target'], random_state=24)

# Average CV score on the training set was: 0.9427521852709514
exported_pipeline = make_pipeline(
    StackingEstimator(estimator=SGDClassifier(alpha=0.0, eta0=0.1, fit_intercept=False, l1_ratio=0.25, learning_rate="invscaling", loss="log", penalty="elasticnet", power_t=0.1)),
    GradientBoostingClassifier(learning_rate=0.1, max_depth=8, max_features=0.6000000000000001, min_samples_leaf=1, min_samples_split=8, n_estimators=100, subsample=0.9500000000000001)
)
# Fix random state for all the steps in exported pipeline
set_param_recursive(exported_pipeline.steps, 'random_state', 24)

exported_pipeline.fit(training_features, training_target)
results = exported_pipeline.predict(testing_features)
