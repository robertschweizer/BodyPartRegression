
import numpy as np 
import json
import os, sys

sys.path.append("../")

class LookUp: 
    def __init__(self, model, dataset):
        self.table =  compute_table(model, dataset)
        self.expected_scores = compute_expected_scores(model, dataset)

    def print(self): 
        for landmark, values in self.table.items(): 
            mean = np.round(values["mean"], 3)
            std = np.round(values["std"], 3)
            print(f"{landmark:<15}:\t {mean}+-{std}")
    
    def save(self, path): 
        filename = path + "lookuptable.json"
        with open(filename, "w") as f:
            json.dump(self.table, f)


def compute_table(model, dataset): 
    landmark_names = dataset.landmark_names
    score_matrix = model.compute_slice_score_matrix(dataset)

    mean_values = np.nanmean(score_matrix, axis=0)
    std_values = np.nanstd(score_matrix, axis=0)

    table = {l: {"mean": mean_values[i], "std": std_values[i]} for i, l in enumerate(landmark_names)}

    return table

def compute_expected_scores(model, dataset): 
    score_matrix = model.compute_slice_score_matrix(dataset)
    return np.nanmean(score_matrix, axis=0)